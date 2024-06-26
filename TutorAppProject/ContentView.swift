//
//  ContentView.swift
//  TutorAppProject
//
//  Created by Admin on 2024-06-26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            Group {
                if authViewModel.isLoggedIn {
                    DashboardView()
                } else {
                    SplashScreenView()
                }
            }
        }
    }
}
