//
//  AssignmentListView.swift
//  Tutor App
//
//  Created by Muthu on 02/08/24.
//

import SwiftUI
import Firebase

struct AssignmentListView: View {
    @State private var assignmentURLs: [URL] = []

    var body: some View {
        VStack {
            if assignmentURLs.isEmpty {
                Text("No uploaded assignments")
                    .font(.headline)
                    .padding()
            } else {
                List(assignmentURLs, id: \.self) { url in
                    Link("View Assignment", destination: url)
                }
            }
        }
        .onAppear {
            fetchAssignments()
        }
        .navigationBarTitle("Assignments", displayMode: .inline)
    }

    func fetchAssignments() {
        let databaseRef = Database.database().reference()
        let assignmentsRef = databaseRef.child("assignments")

        assignmentsRef.observeSingleEvent(of: .value) { snapshot in
            var urls: [URL] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let value = snapshot.value as? [String: Any],
                   let fileURLString = value["fileURL"] as? String,
                   let fileURL = URL(string: fileURLString) {
                    urls.append(fileURL)
                }
            }
            assignmentURLs = urls
        }
    }
}

#Preview {
    AssignmentListView()
}
