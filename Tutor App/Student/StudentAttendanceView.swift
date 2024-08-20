//
//  StudentAttendanceView.swift
//  Tutor App
//
//  Created by Midhun on 20/08/24.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct StudentAttendanceView: View {
    @State private var attendanceRecords: [AttendanceRecord] = []
    @State private var errorMessage: String?
    
    var studentId: String // Pass the student ID
    
    var body: some View {
        VStack {
            Text("My Attendance")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            List(attendanceRecords) { record in
                HStack {
                    Text(record.date)
                    Spacer()
                    Text(record.present ? "Present" : "Absent")
                        .foregroundColor(record.present ? .green : .red)
                }
                .padding()
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear(perform: fetchAttendance)
    }
    
    private func fetchAttendance() {
        let databaseRef = Database.database().reference().child("attendance")
        databaseRef.queryOrdered(byChild: "studentId").queryEqual(toValue: studentId).observeSingleEvent(of: .value) { snapshot in
            var fetchedRecords: [AttendanceRecord] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let value = snapshot.value as? [String: Any],
                   let date = value["date"] as? String,
                   let present = value["present"] as? Bool {
                    fetchedRecords.append(AttendanceRecord(date: date, present: present))
                }
            }
            attendanceRecords = fetchedRecords
        } withCancel: { error in
            errorMessage = "Error fetching attendance: \(error.localizedDescription)"
        }
    }
}

struct AttendanceRecord: Identifiable {
    let id = UUID()
    let date: String
    let present: Bool
}

#Preview {
    StudentAttendanceView(studentId: "studentId1") // Example student ID
}

