//
//  SignupView.swift
//  TutorAppProject
//
//  Created by Admin on 2024-06-26.
//
import SwiftUI

struct SignupView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                (colorScheme == .dark ? Color.black : Color.white)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Signup View")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)

                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .textContentType(.password)

                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .textContentType(.password)

                    if let errorMessage = authViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button(action: signup) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(5.0)
                    }
                }
                .padding()
                .navigationTitle("Sign Up")
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            UIApplication.shared.endEditing() // Dismiss keyboard
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }

    func signup() {
        guard password == confirmPassword else {
            authViewModel.errorMessage = "Passwords do not match."
            return
        }
        authViewModel.signup(email: email, password: password) { success in
            if success {
                print("success")
            }
        }
    }
}
