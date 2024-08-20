import SwiftUI

struct TutorSignUpView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?
    @State private var showSuccessPopup = false
    @State private var navigateToLogin = false

    var body: some View {
        NavigationStack {
            VStack {
                Image("tutorBook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)

                Text("Join our community of tutors")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)

                VStack(spacing: 15) {
                    inputField(iconName: "person", placeholder: "Username", text: $username)
                    inputField(iconName: "envelope", placeholder: "Email", text: $email, keyboardType: .emailAddress)
                    inputField(iconName: "lock", placeholder: "Password", text: $password, isSecure: true)
                    inputField(iconName: "lock.fill", placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)
                }

                Button(action: {
                    signupUser(email: email, password: password, username: username, userType: "tutor") { result in
                        switch result {
                        case .success:
                            showSuccessPopup = true
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                        }
                    }
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 20)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }

                Spacer()
                
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 14))
                    Button(action: {
                        navigateToLogin = true
                    }) {
                        Text("Login")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 20)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.2), Color.blue.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            )
            .navigationBarBackButtonHidden(true)
            .background(
                NavigationLink(destination: TutorLoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
            )
            .alert(isPresented: $showSuccessPopup) {
                Alert(
                    title: Text("Success"),
                    message: Text("Your account has been created successfully!"),
                    dismissButton: .default(Text("OK")) {
                        navigateToLogin = true
                    }
                )
            }
        }
    }
    
    private func inputField(iconName: String, placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType = .default, isSecure: Bool = false) -> some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
                .padding(.leading, 10)
            if isSecure {
                SecureField(placeholder, text: text)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                    .padding(.trailing, 10)
            } else {
                TextField(placeholder, text: text)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                    .padding(.trailing, 10)
                    .keyboardType(keyboardType)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TutorSignUpView()
}
