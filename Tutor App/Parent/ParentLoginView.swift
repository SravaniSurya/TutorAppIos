//
//  ParentLoginView.swift
//  Tutor App
//
//  Created by Midhun on 17/07/24.
//

import SwiftUI

struct ParentLoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
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
                
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            NavigationLink(destination: ParentResetPassword()) {
                Text("Forgot Password?")
                    .foregroundColor(.blue)
                    .padding()
            }

        }
        .padding()
        .background(Color.white)
        .navigationTitle("Login")
    }
    
}

#Preview {
    ParentLoginView()
}
