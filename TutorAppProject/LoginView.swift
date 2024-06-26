//
//  LoginView.swift
//  TutorAppProject
//
//  Created by Admin on 2024-06-26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showForgotPasswordAlert = false
    @State private var showResetPasswordView = false // Added state for showing ResetPasswordView
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                (colorScheme == .dark ? Color.black : Color.white)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Login View")
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

                    if let errorMessage = authViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button(action: login) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(5.0)
                    }

                    Button(action: goToSignup) {
                        Text("Sign Up")
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }

                    Button(action: {
                        showResetPasswordView = true // Show ResetPasswordView
                    }) {
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }
                    .sheet(isPresented: $showResetPasswordView) {
                        ResetPasswordView().environmentObject(authViewModel)
                    }
                }
                .padding()
                .alert(isPresented: $showForgotPasswordAlert) {
                    Alert(
                        title: Text("Forgot Password"),
                        message: Text("An email with instructions to reset your password has been sent."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .sheet(isPresented: $authViewModel.showSignup) {
                    SignupView().environmentObject(authViewModel)
                }
                .fullScreenCover(isPresented: $authViewModel.showDashboard) {
                    DashboardView().environmentObject(authViewModel)
                }
            }
            .navigationTitle("Login")
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
        .navigationBarHidden(true) // Hides the navigation bar
        .onAppear {
            // Ensure the login screen is shown on initial load or after logout
            authViewModel.checkUserLoggedIn()
            authViewModel.showLogin = true
        }
    }

    func login() {
        authViewModel.login(email: email, password: password)
    }

    func goToSignup() {
        authViewModel.showSignup = true
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
