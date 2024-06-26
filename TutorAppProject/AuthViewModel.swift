//
//  AuthViewModel.swift
//  TutorAppProject
//
//  Created by Admin on 2024-06-26.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var showLogin: Bool = false
    @Published var showSignup: Bool = false
    @Published var showDashboard: Bool = false
    @Published var errorMessage: String? = nil

    init() {
        // Check if a user is already logged in on initialization
        self.isLoggedIn = Auth.auth().currentUser != nil
        self.showDashboard = self.isLoggedIn
    }

    func checkUserLoggedIn() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        self.showDashboard = self.isLoggedIn
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = "Login error: Enter valid email or password"
                print(self.errorMessage ?? "Unknown error")
            } else {
                self.checkUserLoggedIn() // Update login status
                self.showLogin = false
                self.showDashboard = true // Show dashboard on successful login
            }
        }
    }

    func signup(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .invalidEmail:
                        self.errorMessage = "Signup error: The email address is badly formatted."
                    case .emailAlreadyInUse:
                        self.errorMessage = "Signup error: The email address is already in use."
                    case .weakPassword:
                        self.errorMessage = "Signup error: The password is too weak."
                    default:
                        self.errorMessage = "Signup error: \(error.localizedDescription)"
                    }
                } else {
                    self.errorMessage = "Signup error: \(error.localizedDescription)"
                }
                print(self.errorMessage ?? "Unknown error")
                completion(false) // Signup failed
            } else {
                self.checkUserLoggedIn() // Update login status
                self.showSignup = false
                self.showDashboard = true // Show dashboard on successful signup
                completion(true) // Signup successful
            }
        }
    }

    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .invalidEmail:
                        self.errorMessage = "Reset password error: The email address is badly formatted."
                    case .userNotFound:
                        self.errorMessage = "Reset password error: There is no user record corresponding to this email."
                    default:
                        self.errorMessage = "Reset password error: \(error.localizedDescription)"
                    }
                } else {
                    self.errorMessage = "Reset password error: \(error.localizedDescription)"
                }
                print(self.errorMessage ?? "Unknown error")
            } else {
                print("Password reset email sent successfully")
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.showDashboard = false // Hide dashboard on logout
            self.showLogin = true
        } catch let signOutError as NSError {
            self.errorMessage = "Error signing out: \(signOutError.localizedDescription)"
            print(self.errorMessage ?? "Unknown error")
        }
    }
}
