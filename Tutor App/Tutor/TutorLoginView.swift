//
//  TutorLoginView.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct TutorLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    Image("tutorIc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)

                    Image("tutorConnect")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                }

                Text("Provide your email and password")
                    .foregroundStyle(.gray)

                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)

                Button(action: {
                    loginUser(email: email, password: password, userType: "tutor")
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                NavigationLink(destination: TutorDashboard(), isActive: $isLoggedIn) {
                    EmptyView()
                }

                NavigationLink(destination: TutorResetPassword()) {
                    Text("Forgot Password?")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.2), Color.blue.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            )
            .navigationTitle("Tutor Login")
        }
        .navigationBarBackButtonHidden(true) // Hide the back button
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
                    errorMessage = "User is not a valid \(userType)."
                }
            } withCancel: { error in
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    TutorLoginView()
}
