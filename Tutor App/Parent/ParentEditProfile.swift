//
//  ParentEditProfile.swift
//  Tutor App
//
//  Created by Muthu on 24/08/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ParentEditProfile: View {
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle.fill")
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var email: String = ""
    @State private var userType: String = "student" // Set default userType
    @State private var showSuccessAlert = false
    @State private var savedData: [String: String] = [:]

    var body: some View {
        VStack(spacing: 20) {
            // Profile Image
            profileImage?
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding()
                .onTapGesture {
                    showingImagePicker = true
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            // Name Field
            CustomTextField(label: "Name", text: $name)
                .padding(.horizontal)
            
            // Email Field (Not editable)
            CustomTextField(label: "Email", text: $email, isEditable: false)
                .padding(.horizontal)
            
            // Save Button
            Button(action: saveProfile) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            .alert(isPresented: $showSuccessAlert) {
                Alert(
                    title: Text("Profile Saved"),
                    message: Text("Name: \(savedData["name"] ?? "")\nEmail: \(savedData["email"] ?? "")"),
                    dismissButton: .default(Text("OK"))
                )
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 10)
        .onAppear(perform: loadUserData)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    private func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Pass "student" as the userType when fetching user data
        fetchUserProfile(uid: uid, userType: "parent") { result in
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

