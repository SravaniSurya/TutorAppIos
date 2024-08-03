//
//  UploadStorageView.swift
//  Tutor App
//
//  Created by Muthu on 02/08/24.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseStorage

struct UploadStorageView: View {
    @State private var selectedFileURL: URL? = nil
    @State private var showDocumentPicker = false
    @State private var errorMessage: String?
    @State private var showSuccessAlert = false

    var body: some View {
        VStack {
            Text("Tutor Connect")
                .font(.title)
                .padding()

            Spacer()

            Text("Select File From Storage")
                .font(.headline)
                .padding()

            Button(action: {
                showDocumentPicker = true
            }) {
                Text("Select File")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker(selectedFileURL: $selectedFileURL)
            }

            Button(action: {
                if let fileURL = selectedFileURL {
                    loadFileData(fileURL: fileURL) { data in
                        if let data = data {
                            uploadData(data, fileName: fileURL.lastPathComponent)
                        } else {
                            errorMessage = "Unable to load files."
                        }
                    }
                }
            }) {
                Text("Upload")
                    .padding()
                    .background(selectedFileURL != nil ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(selectedFileURL == nil)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Success"),
                message: Text("File URL saved to database successfully"),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func loadFileData(fileURL: URL, completion: @escaping (Data?) -> Void) {
        do {
            let data = try Data(contentsOf: fileURL)
            completion(data)
        } catch {
            print("Error loading file data: \(error.localizedDescription)")
            completion(nil)
        }
    }

    private func uploadData(_ data: Data, fileName: String) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let fileRef = storageRef.child("assignments/\(fileName)")

        fileRef.putData(data, metadata: nil) { _, error in
            if let error = error {
                print("Error uploading file: \(error.localizedDescription)")
                return
            }

            fileRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                saveFileURLToDatabase(downloadURL)
            }
        }
    }

    private func saveFileURLToDatabase(_ fileURL: URL) {
        let databaseRef = Database.database().reference()
        let assignmentsRef = databaseRef.child("assignments")
        let newAssignmentRef = assignmentsRef.childByAutoId()
        newAssignmentRef.setValue(["fileURL": fileURL.absoluteString]) { error, _ in
            if let error = error {
                print("Error saving file URL to database: \(error.localizedDescription)")
            } else {
                showSuccessAlert = true
            }
        }
    }
}

#Preview {
    UploadStorageView()
}
