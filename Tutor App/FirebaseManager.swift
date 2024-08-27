//
//  FirebaseManager.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.

import FirebaseAuth
import FirebaseDatabase

/// Signs up a new user and stores their information in Firebase Realtime Database.
func signupUser(email: String, password: String, username: String, userType: String, completion: @escaping (Result<Void, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let error = error {
            print("Error creating user: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
        guard let uid = authResult?.user.uid else {
            let error = NSError(domain: "Firebase", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve user ID."])
            print("Error: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
        // Prepare user data
        let userData: [String: Any] = [
            "username": username,
            "email": email,
            "userType": userType // "tutor", "parent", or "student"
        ]
        
        // Determine reference based on userType
        let ref: DatabaseReference
        switch userType {
        case "tutor":
            ref = Database.database().reference().child("tutors").child(uid)
        case "parent":
            ref = Database.database().reference().child("parents").child(uid)
        case "student":
            ref = Database.database().reference().child("students").child(uid)
        default:
            let error = NSError(domain: "InvalidUserType", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid userType."])
            print("Error: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
        // Save user data to Firebase
        ref.setValue(userData) { error, _ in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

/// Fetches user profile data from Firebase Realtime Database based on userType.
func fetchUserProfile(uid: String, userType: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
    let ref: DatabaseReference
    
    switch userType {
    case "tutor":
        ref = Database.database().reference().child("tutors").child(uid)
    case "parent":
        ref = Database.database().reference().child("parents").child(uid)
    case "student":
        ref = Database.database().reference().child("students").child(uid)
    default:
        let error = NSError(domain: "InvalidUserType", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid userType."])
        completion(.failure(error))
        return
    }
    
    // Fetch user data from Firebase
    ref.observeSingleEvent(of: .value) { snapshot in
        guard let value = snapshot.value as? [String: Any] else {
            let error = NSError(domain: "Firebase", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch user data."])
            completion(.failure(error))
            return
        }
        completion(.success(value))
    } withCancel: { error in
        completion(.failure(error))
    }
}
