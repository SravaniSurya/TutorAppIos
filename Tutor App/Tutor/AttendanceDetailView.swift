import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct AttendanceDetailView: View {
    var student: Student
    @State private var attendance: AttendanceStatus = .absent
    @State private var remark: String = ""
    @State private var date = Date()
    @State private var errorMessage: String?
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Mark Attendance for \(student.name)")
                    .font(.title2)
                    .bold()
                    .padding()

                // Date Picker for selecting the date
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .padding()
                    .datePickerStyle(GraphicalDatePickerStyle())

                // Picker to select attendance status
                Picker("Status", selection: $attendance) {
                    Text("Present").tag(AttendanceStatus.present)
                    Text("Absent").tag(AttendanceStatus.absent)
                        .foregroundColor(.red)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // TextField for remarks
                TextField("Remark", text: $remark)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Submit button
                Button(action: submitAttendance) {
                    Text("Submit")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Success"),
                        message: Text("Attendance has been successfully submitted."),
                        dismissButton: .default(Text("OK")) {
                            // Dismiss the view when OK is tapped
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }

                // Display error message if any
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
            .background(Color.white.opacity(0.8)) // Background color of the content
            .cornerRadius(15)
            .shadow(radius: 10)
        }
        .navigationTitle("Attendance Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            print("Student: \(student.name)") // Debug print
        }
    }

    private func submitAttendance() {
        let ref = Database.database().reference().child("attendance").child(dateFormatter.string(from: date)).child(student.id)
        let data: [String: Any] = [
            "status": attendance.rawValue,
            "remark": remark
        ]

        ref.setValue(data) { error, _ in
            if let error = error {
                self.errorMessage = "Failed to submit attendance: \(error.localizedDescription)"
            } else {
                self.errorMessage = nil
                // Show success alert
                self.showAlert = true
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}

enum AttendanceStatus: String {
    case present
    case absent
}

struct AttendanceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceDetailView(student: Student(id: "1", name: "John Doe"))
    }
}
