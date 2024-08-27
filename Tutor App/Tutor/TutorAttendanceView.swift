import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct TutorAttendanceView: View {
    @State private var students: [Student] = []
    @State private var selectedStudent: Student?
    @State private var showDetailView = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Select a Student to Mark Attendance")
                    .font(.largeTitle)
                    .padding()

                List(students) { student in
                    Button(action: {
                        print("Selected Student: \(student.name)")
                        self.selectedStudent = student
                        self.showDetailView = true
                    }) {
                        Text(student.name)
                            .font(.headline)
                            .padding()
                    }
                }
                .navigationTitle("Student List")
                .navigationBarItems(trailing: Button("Refresh") {
                    loadStudents()
                })
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .onAppear(perform: loadStudents)
            .sheet(isPresented: $showDetailView) {
                if let student = selectedStudent {
                    AttendanceDetailView(student: student)
                }
            }
        }
    }

    private func loadStudents() {
        let ref = Database.database().reference().child("students")
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else {
                self.errorMessage = "Failed to parse students data."
                return
            }
            
            self.students = value.map { (key, studentData) in
                Student(
                    id: key,
                    name: studentData["username"] as? String ?? ""
                )
            }
        } withCancel: { error in
            self.errorMessage = "Failed to load students: \(error.localizedDescription)"
        }
    }
}

struct Student: Identifiable {
    let id: String
    let name: String
}

struct TutorAttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        TutorAttendanceView()
    }
}
