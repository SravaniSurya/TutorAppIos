//
//  SplashScreenView.swift
//  TutorAppProject
//
//  Created by Admin on 2024-06-26.
//
import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
//            // Background image
            Image("0")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.3) // Adjust opacity as desired
            
            Color.blue
                .opacity(0.4)
            VStack {
                Text("Tutor App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if authViewModel.isLoggedIn {
                    authViewModel.showLogin = false
                } else {
                    authViewModel.showLogin = true
                }
            }
        }
        .navigationDestination(isPresented: $authViewModel.showLogin) {
            LoginView()
                .environmentObject(authViewModel)
        }
    }
}
