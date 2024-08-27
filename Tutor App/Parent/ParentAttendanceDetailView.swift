//
//  ParentAttendanceDetailView.swift
//  Tutor App
//
//  Created by Muthu on 24/08/24.
//

import SwiftUI
import FirebaseDatabase

struct ParentAttendanceDetailView: View {
    let student: Student
    @State private var attendanceRecords: [AttendanceRecord] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("\(student.name) Attendance Records")
                .font(.largeTitle)
                .padding()
            
            if isLoading {
                ProgressView()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(attendanceRecords) { record in
                    VStack(alignment: .leading) {
                        Text("Date: \(dateFormatter.string(from: record.date))")
                        Text("Status: \(record.status.rawValue.capitalized)")
                        if let remark = record.remark, !remark.isEmpty {
                            Text("Remark: \(remark)")
                        }
                    }
                    .padding()
                }
            }
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .onAppear(perform: loadAttendanceRecords)
        .navigationTitle("\(student.name) Attendance")
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
                        
                        if id == student.id {
                            let date = dateFormatter.date(from: dateKey) ?? Date()
                            let record = AttendanceRecord(studentId: id, date: date, status: status, remark: remark)
                            
                            records.append(record)
                        }
                    }
                }
            }
            
            if records.isEmpty {
                self.errorMessage = "No attendance record for this student"
            } else {
                self.errorMessage = nil
            }
            
            self.attendanceRecords = records
            self.isLoading = false
        } withCancel: { error in
            self.errorMessage = "Failed to load attendance records: \(error.localizedDescription)"
            print("Firebase Error: \(error.localizedDescription)") // Debug print statement
            self.isLoading = false
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}



