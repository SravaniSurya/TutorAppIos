//
//  ResetPassword.swift
//  TutorAppProject
//
//  Created by Admin on 2024-06-26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ResetPasswordView: View {
    @State private var email = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var errorMessage: String?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: resetPassword) {
                Text("Reset Password")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5.0)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Password Reset"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                if errorMessage == nil {
                    presentationMode.wrappedValue.dismiss() // Dismiss view only if there is no error
                }
            })
        }
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                errorMessage = "Error: \(error.localizedDescription)"
                alertMessage = errorMessage ?? "Unknown error"
                showAlert = true
                print(errorMessage ?? "Unknown error")
            } else {
                errorMessage = nil // Clear any previous error message
                alertMessage = "Password reset email sent successfully"
                showAlert = true
                print("Password reset email sent successfully")
            }
        }
    }
}
