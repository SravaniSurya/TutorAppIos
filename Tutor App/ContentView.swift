//
//  ContentView.swift
//  Tutor App
//
//  Created by Midhun on 17/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingSplash = true
    
    var body: some View {
        Group {
            if isShowingSplash {
                SplashScreenView()
            } else {
                DashboardView()
            }
        }
        .onAppear {
            // Delay for 2 seconds before transitioning to DashboardView
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isShowingSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
