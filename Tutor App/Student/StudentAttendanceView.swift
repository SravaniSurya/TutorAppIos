import SwiftUI
import FirebaseDatabase

struct StudentAttendanceView: View {
    @State private var attendanceRecords: [AttendanceRecord] = []
    @State private var errorMessage: String?
    
    var studentId: String // Pass the actual student ID here

    var body: some View {
        VStack {
            Text("Attendance Records")
                .font(.largeTitle)
                .padding()
            
            List(attendanceRecords) { record in
                VStack(alignment: .leading) {
                    Text("Date: \(record.date, formatter: dateFormatter)")
                    Text("Status: \(record.status.rawValue.capitalized)")
                    if let remark = record.remark, !remark.isEmpty {
                        Text("Remark: \(remark)")
                    }
                }
                .padding()
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .onAppear(perform: loadAttendanceRecords)
    }
    
    private func loadAttendanceRecords() {
        let ref = Database.database().reference().child("attendance")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            var records: [AttendanceRecord] = []
            
            for dateSnapshot in snapshot.children.allObjects as! [DataSnapshot] {
                let dateKey = dateSnapshot.key
                
                for studentSnapshot in dateSnapshot.children.allObjects as! [DataSnapshot] {
                    if let studentChild = studentSnapshot as? DataSnapshot,
                       let value = studentChild.value as? [String: Any] {
                        let id = studentSnapshot.key
                        let statusString = value["status"] as? String ?? ""
                        let remark = value["remark"] as? String
                        
                        guard let status = Status(rawValue: statusString) else {
                            continue
                        }
                        
                        if id == studentId {
                            let date = dateFormatter.date(from: dateKey) ?? Date()
                            let record = AttendanceRecord(studentId: id, date: date, status: status, remark: remark)
                            
                            records.append(record)
                        }
                    }
                }
            }
            
            if records.isEmpty {
                self.errorMessage = "No attendance records"
            } else {
                self.errorMessage = nil
            }
            
            self.attendanceRecords = records
            print("Fetched records: \(records)") // Debug print statement
        } withCancel: { error in
            self.errorMessage = "Failed to load attendance records: \(error.localizedDescription)"
            print("Firebase Error: \(error.localizedDescription)") // Debug print statement
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}

struct StudentAttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        StudentAttendanceView(studentId: "PeBb34MYgUNnITlCvCj2cvsRTHK2")
    }
}

struct AttendanceRecord: Identifiable {
    let id: String // Change this to a unique identifier
    let date: Date
    let status: Status
    let remark: String?
    
    init(studentId: String, date: Date, status: Status, remark: String?) {
        self.id = "\(studentId)_\(date.timeIntervalSince1970)" // Unique ID combining student ID and date
        self.date = date
        self.status = status
        self.remark = remark
    }
}

enum Status: String {
    case present
    case absent
}

