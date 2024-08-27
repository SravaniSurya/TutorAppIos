//
//  AssignmentListView.swift
//  Tutor App
//
//  Created by Muthu on 02/08/24.

import SwiftUI
import Firebase

struct AssignmentListView: View {
    @State private var assignments: [Assignment] = []

    var body: some View {
        NavigationStack {
            VStack {
                if assignments.isEmpty {
                    Text("No uploaded assignments")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(assignments, id: \.id) { assignment in
                        AssignmentRow(assignment: assignment)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear {
                fetchAssignments()
            }
            .background(Color(UIColor.systemBackground).ignoresSafeArea())
            .navigationTitle("Assignments")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
    }

    func fetchAssignments() {
        let databaseRef = Database.database().reference()
        let assignmentsRef = databaseRef.child("assignments")

        assignmentsRef.observeSingleEvent(of: .value) { snapshot in
            var fetchedAssignments: [Assignment] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let value = snapshot.value as? [String: Any],
                   let fileURLString = value["fileURL"] as? String,
                   let fileURL = URL(string: fileURLString),
                   let uploaderRole = value["uploaderRole"] as? String {
                    let assignment = Assignment(id: snapshot.key, fileURL: fileURL, uploaderRole: uploaderRole)
                    fetchedAssignments.append(assignment)
                }
            }
            assignments = fetchedAssignments
        }
    }
}

struct AssignmentRow: View {
    var assignment: Assignment

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Uploaded by (\(assignment.uploaderRole))")
                    .font(.headline)
                    .padding(.bottom, 2)
                Link("View Assignment", destination: assignment.fileURL)
                    .foregroundColor(.blue)
                    .font(.subheadline)
                    .padding(.bottom, 4)
                Text(assignment.fileURL.lastPathComponent)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white) 
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
    }
}

// Model to represent an assignment
struct Assignment: Identifiable {
    var id: String
    var fileURL: URL
    var uploaderRole: String
}

#Preview {
    AssignmentListView()
}
