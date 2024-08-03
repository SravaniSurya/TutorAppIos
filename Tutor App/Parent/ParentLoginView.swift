//
//  ParentLoginView.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ParentLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    Image("parentIc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)

                    Image("tutorConnect")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                }
                .padding(.horizontal)

                Text("Provide Your Email And Password")
                    .foregroundColor(.gray)

                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)

                Button(action: {
                    loginUser(email: email, password: password, userType: "parent")
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                NavigationLink(destination: ParentDashboard(), isActive: $isLoggedIn) {
                    EmptyView()
                }

                NavigationLink(destination: ParentResetPassword()) {
                    Text("Forgot Password?")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
            .navigationTitle("Parent Login")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true) // Hide the back button
        }
    }

    private func loginUser(email: String, password: String, userType: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }

            guard let uid = authResult?.user.uid else { return }
            let ref = Database.database().reference().child(userType + "s").child(uid)
            ref.observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    isLoggedIn = true
                } else {
                    errorMessage = "User is not a valid parent."
                }
            }
        }
    }
}

#Preview {
    ParentLoginView()
}
