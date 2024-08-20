//
//  AssignmentListView.swift
//  Tutor App
//
//  Created by Midhun on 02/08/24.
//

import SwiftUI
import Firebase

struct AssignmentListView: View {
    @State private var assignmentURLs: [URL] = []

    var body: some View {
        NavigationStack {
            VStack {
                if assignmentURLs.isEmpty {
                    Text("No uploaded assignments")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(assignmentURLs, id: \.self) { url in
                        AssignmentRow(url: url)
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

struct AssignmentRow: View {
    var url: URL

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Assignment")
                    .font(.headline)
                    .padding(.bottom, 2)
                Link("View Assignment", destination: url)
                    .foregroundColor(.blue)
                    .font(.subheadline)
                    .padding(.bottom, 4)
                Text(url.lastPathComponent)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white) // Card background color
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    AssignmentListView()
}
