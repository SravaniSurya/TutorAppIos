//
//  ParentResetPassword.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.
//

import SwiftUI
import FirebaseAuth

struct ParentResetPassword: View {
    @State private var email = ""
    @State private var errorMessage: String?
    @State private var successMessage: String?
    @State private var isResetSuccess = false
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                Image("parentIc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)

                Text("Reset Password")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Provide your email to receive a password reset link")
                    .font(.body)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)

                Button("Send Reset Link") {
                    sendResetLink(email: email)
                }
                .foregroundColor(.white)
                .padding(.vertical, 5)
                .frame(width: 300)
                .background(Color.blue)
                .cornerRadius(10)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"),
                      message: Text(successMessage ?? "Check your email for the password reset link."),
                      dismissButton: .default(Text("OK"), action: {
                          isResetSuccess = true // Navigate to TutorLoginView
                      }))
            }
            .background(
                NavigationLink(destination: TutorLoginView(), isActive: $isResetSuccess) {
                    EmptyView()
                }
            )
        }
    }

    private func sendResetLink(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            successMessage = "Password reset link sent to \(email)."
            showAlert = true // Show alert
        }
    }
}

#Preview {
    ParentResetPassword()
}
