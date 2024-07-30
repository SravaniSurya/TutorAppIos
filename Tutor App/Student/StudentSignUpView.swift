//
//  StudentSignUpView.swift
//  Tutor App
//
//  Created by Midhun on 17/07/24.
//

import SwiftUI

struct StudentSignUpView: View {
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?
    @State private var isSignedUp = false // State for navigation
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("tutorBook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)

                Text("Welcome ! Please create your student account to access our tutoring service and connect with teachers")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .padding()
                
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)
                
                Button(action: {
                    signupUser(email: email, password: password, username: username, userType: "student") { result in
                        switch result {
                        case .success:
                            isSignedUp = true // Trigger navigation
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                        }
                    }

                }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Spacer() // To push the login button to the bottom
                
                HStack {
                    Text("Already have an account?")
                    Button(action: {
                        
                    }) {
                        Text("Login")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
            .padding()
            .background(
                NavigationLink(destination: StudentLoginView(), isActive: $isSignedUp) {
                    EmptyView()
                }
            )
        }
    }
}

#Preview {
    StudentSignUpView()
}
