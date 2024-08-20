import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct EditProfileView: View {
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle.fill")
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var email: String = ""
    @State private var userType: String = "" // Store the user type (tutor, parent, student)
    @State private var showSuccessAlert = false // Control showing the success alert
    @State private var savedData: [String: String] = [:] // Store saved data

    var body: some View {
        VStack {
            // Profile Image
            VStack {
                profileImage?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.top, 20)
                    .onTapGesture {
                        showingImagePicker = true
                    }

                Text("Tap to select profile image")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .padding(.top, 5)
            }
            .padding()

            // Profile Information Card
            VStack(alignment: .leading, spacing: 15) {
                // Name Field
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }

                // Email Field (Not editable)
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .disabled(true) // Disable editing for email
                }

                // Save Button
                Button(action: saveProfile) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .padding(.top, 20)
                .alert(isPresented: $showSuccessAlert) {
                    Alert(
                        title: Text("Profile Saved"),
                        message: Text("Name: \(savedData["name"] ?? "")\nEmail: \(savedData["email"] ?? "")"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground))
            .cornerRadius(20)
            .shadow(radius: 10)
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    private func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        userType = "tutor"
        
        fetchUserProfile(uid: uid, userType: userType) { result in
            switch result {
            case .success(let userData):
                // Update state with fetched user data
                name = userData["username"] as? String ?? ""
                email = userData["email"] as? String ?? ""
            case .failure(let error):
                print("Error fetching user data: \(error.localizedDescription)")
            }
        }
    }

    private func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }

    private func saveProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userData: [String: Any] = [
            "username": name
        ]
        
        let ref: DatabaseReference
        
        switch userType {
        case "tutor":
            ref = Database.database().reference().child("tutors").child(uid)
        case "parent":
            ref = Database.database().reference().child("parents").child(uid)
        case "student":
            ref = Database.database().reference().child("students").child(uid)
        default:
            print("Invalid userType")
            return
        }
        
        ref.updateChildValues(userData) { error, _ in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                // Save data locally for displaying
                savedData = [
                    "name": name,
                    "email": email
                ]
                showSuccessAlert = true
            }
        }
    }
}

// Image Picker for selecting profile picture
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.editedImage] as? UIImage {
                parent.image = uiImage
            } else if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}

// Preview
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
