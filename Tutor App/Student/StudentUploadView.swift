import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseStorage

struct StudentUploadView: View {
    @State private var selectedFileURL: URL? = nil
    @State private var showDocumentPicker = false
    @State private var errorMessage: String?
    @State private var showSuccessAlert = false
    
    // Environment variable to control view presentation
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Header
            VStack(spacing: 10) {
                Text("Student Connect")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Text("Upload Your Assignment")
                    .font(.headline)
                    .foregroundColor(Color.white.opacity(0.8))
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15)
            .shadow(radius: 10)
            
            Spacer()
            
            // File selection button
            Button(action: {
                showDocumentPicker = true
            }) {
                Text("Select File")
                    .padding()
                    .font(.headline)
                    .background(Color.white)
                    .foregroundColor(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 10)
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker(selectedFileURL: $selectedFileURL)
            }
            
            // Upload button
            Button(action: {
                if let fileURL = selectedFileURL {
                    loadFileData(fileURL: fileURL) { data in
                        if let data = data {
                            uploadData(data, fileName: fileURL.lastPathComponent)
                        } else {
                            errorMessage = "Unable to load file data."
                        }
                    }
                }
            }) {
                Text("Upload")
                    .padding()
                    .font(.headline)
                    .background(selectedFileURL != nil ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
            }
            .disabled(selectedFileURL == nil)

            // Error message
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .navigationTitle("Upload Assignment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Assignment uploaded successfully"),
                dismissButton: .default(Text("OK"), action: {
                    // Dismiss the view after the alert is dismissed
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        presentationMode.wrappedValue.dismiss()
                    }
                })
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
    StudentUploadView()
}
