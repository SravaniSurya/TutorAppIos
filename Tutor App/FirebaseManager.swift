//
//  FirebaseManager.swift
//  Tutor App
//
//  Created by Midhun on 17/07/24.

import FirebaseAuth
import FirebaseDatabase

func signupUser(email: String, password: String, username: String, userType: String, completion: @escaping (Result<Void, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let uid = authResult?.user.uid else { return }
        
        // Store user data in Realtime Database under different paths based on userType
        let userData: [String: Any] = [
            "username": username,
            "email": email,
            "userType": userType,
            "password": password  // "tutor", "parent", or "student"
        ]
        
        let ref: DatabaseReference
        
        switch userType {
        case "tutor":
            ref = Database.database().reference().child("tutors").child(uid)
            print("Stored in tutor database")
        case "parent":
            ref = Database.database().reference().child("parents").child(uid)
            print("Stored in parent database")
        case "student":
            ref = Database.database().reference().child("students").child(uid)
            print("Stored in student database")
        default:
            completion(.failure(NSError(domain: "Invalid userType", code: 0, userInfo: nil)))
            return
        }
        
        ref.setValue(userData) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
