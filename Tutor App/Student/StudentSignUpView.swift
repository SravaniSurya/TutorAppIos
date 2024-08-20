import SwiftUI

struct StudentSignUpView: View {
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?
    @State private var isSignedUp = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("tutorBook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)

                Text("Welcome! Please create your student account to access our tutoring service and connect with teachers.")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)

                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        TextField("Username", text: $username)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                            .padding(.trailing, 10)
                    }
                    .padding(.horizontal, 20)

                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        TextField("Email", text: $email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                            .padding(.trailing, 10)
                    }
                    .padding(.horizontal, 20)
                    .keyboardType(.emailAddress)

                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        SecureField("Password", text: $password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                            .padding(.trailing, 10)
                    }
                    .padding(.horizontal, 20)

                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                            .padding(.trailing, 10)
                    }
                    .padding(.horizontal, 20)
                }

                Button(action: {
                    signupUser(email: email, password: password, username: username, userType: "student") { result in
                        switch result {
                        case .success:
                            isSignedUp = true
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
                        isSignedUp = true
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
                NavigationLink(destination: StudentLoginView(), isActive: $isSignedUp) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}

#Preview {
    StudentSignUpView()
}
