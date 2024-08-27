//
//  TutorApp.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.
//

import SwiftUI
import Firebase

@main
struct TutorApp: App {
    init() {
        FirebaseApp.configure() // Configure Firebase here
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
