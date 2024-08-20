import SwiftUI
import Firebase
import FirebaseDatabase

struct TutorAttendanceView: View {
    @State private var students: [Student] = []
    @State private var attendance: [String: Bool] = [:] // Student ID and their attendance status
    @State private var showSuccessAlert = false
    @State private var errorMessage: String?
    
    var classId: String // Pass the class ID for attendance tracking
    
    var body: some View {
        VStack {
            Text("Mark Student Attendance")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            List(students) { student in
                HStack {
                    Text(student.name)
                    Spacer()
                    Toggle(isOn: Binding(
                        get: { attendance[student.id] ?? false },
                        set: { attendance[student.id] = $0 }
                    )) {
                        Text("Present")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                }
                .padding()
            }
            
            Button(action: submitAttendance) {
                Text("Submit Attendance")
                    .padding()
                    .font(.headline)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
            }
            .padding()
            .disabled(students.isEmpty)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear(perform: fetchStudents)
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Attendance has been recorded successfully."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func fetchStudents() {
        let databaseRef = Database.database().reference().child("students")
        
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            var fetchedStudents: [Student] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let value = snapshot.value as? [String: Any],
                   let name = value["name"] as? String {
                    let id = snapshot.key // Using the key as the student ID
                    fetchedStudents.append(Student(id: id, name: name))
                }
            }
            
            // Debug print statement
            print("Fetched students: \(fetchedStudents)")
            
            self.students = fetchedStudents
        } withCancel: { error in
            // Debug print statement
            print("Error fetching students: \(error.localizedDescription)")
        }
    }

    private func submitAttendance() {
        let databaseRef = Database.database().reference().child("attendance")
        
        for (studentId, isPresent) in attendance {
            let attendanceRef = databaseRef.child(studentId)
            attendanceRef.setValue(["present": isPresent]) { error, _ in
                if let error = error {
                    errorMessage = "Error recording attendance: \(error.localizedDescription)"
                } else {
                    showSuccessAlert = true
                }
            }
        }
    }

}

struct Student: Identifiable {
    let id: String
    let name: String
}

#Preview {
    TutorAttendanceView(classId: "classId1") // Example class ID
}
