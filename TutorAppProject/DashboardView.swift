//
//  DashboardView.swift
//  TutorAppProject
//
//  Created by Admin on 2024-06-26.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            Text("Welcome to Tutor Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Button(action: logout) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(5.0)
            }
        }
        .padding()
    }

    func logout() {
        authViewModel.logout()
    }
}
