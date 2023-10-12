//
//  UserManger.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 12.10.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser {
    let userId : String
    let isAnoonmus: Bool?
    let email: String?
    let photoUrl: String?
}



final class UserManger {
    
    static let shered = UserManger()
    private init() { }
    
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData: [String: Any] = [
            "user_Id" : auth.uid,
            "data_created": Timestamp(),
        ]
        if let email = auth.email {
            userData["email"] = email
        }
        if let photoUrl = auth.photoUrl {
            userData["photo_url"] = photoUrl
        }
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(),let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
     
        let isAnoonmus = data["isAnoonmus"] as? Bool
        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        
        return DBUser(userId: userId, isAnoonmus: isAnoonmus, email: email, photoUrl: photoUrl)
    }
}
