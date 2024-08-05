//
//  FirebaseManager.swift
//  Tutor App
//
//  Created by Muthu on 17/07/24.

import FirebaseAuth
import FirebaseDatabase

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
        
        // Store user data in Realtime Database under different paths based on userType
        let userData: [String: Any] = [
            "username": username,
            "email": email,
            "userType": userType,
            "password": password
            // "tutor", "parent", or "student"
        ]
        
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
