//
//  TutorApp.swift
//  TutorAppProject
//
//  Created by Admin on 2024-06-26.
//

import SwiftUI
import Firebase

@main
struct TutorApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
