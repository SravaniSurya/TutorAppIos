import SwiftUI
import FirebaseDatabase

struct ParentViewAttendanceView: View {
    @State private var students: [Student] = []
    @State private var selectedStudent: Student?
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(students) { student in
                        NavigationLink(destination: ParentAttendanceDetailView(student: student)) {
                            Text(student.name)
                        }
                    }
                }
            }
            .navigationTitle("Students")
            .onAppear(perform: fetchStudentData)
        }
    }
    
    private func fetchStudentData() {
        let ref = Database.database().reference().child("students") // Change to the correct path
        ref.observeSingleEvent(of: .value) { snapshot in
            print("Snapshot value: \(snapshot.value ?? "No data")") // Debug print

            var fetchedStudents: [Student] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let data = snapshot.value as? [String: Any],
                   let name = data["username"] as? String {
                    let student = Student(id: snapshot.key, name: name)
                    fetchedStudents.append(student)
                }
            }
            self.students = fetchedStudents
            self.isLoading = false
        } withCancel: { error in
            print("Error fetching data: \(error.localizedDescription)") // Debug print
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
