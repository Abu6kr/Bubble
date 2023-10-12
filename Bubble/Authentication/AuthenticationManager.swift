//
//  AuthenticationManager.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 30.09.2023.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

enum AuthProviderOption: String {
    case email = "password"
    case googel = "google.com"
    case apple = "apple.com"
}


final class AuthenticationManger {
    
    static let shered = AuthenticationManger()
    
    private init() { }
    
    
    
    func getAuthenticationUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
   
    func getProviders() throws -> [AuthProviderOption] {
        guard  let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        var privder: [AuthProviderOption] = []
        for provider in providerData {
            if let option =  AuthProviderOption(rawValue: provider.providerID) {
                privder.append(option)
            } else {
                assertionFailure("Provider optiones not found: \(provider.providerID)")
            }
            
        }
        return privder
    }
    
    func sigOut() throws {
       try Auth.auth().signOut()
    }
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        try await user.delete()
    }
    
}

// MARK: Sign IN Email

extension AuthenticationManger {
    @discardableResult
    func creatUser(email: String, password: String) async throws  -> AuthDataResultModel {
      let authDataResute = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResute.user)
        
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws  -> AuthDataResultModel {
        let authDataResute = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResute.user)
    }
    
    func reestPaswored(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    
    func updatePaswwored(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
       try await user.updatePassword(to: password)
    }
    
    func updateemail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updateEmail(to: email)
    }
}


// MARK: Sign IN SSD
extension AuthenticationManger {
 
    @discardableResult
    func siginWitheGoogle(tokens: GoogesSignInResultMolde) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToke, accessToken: tokens.accesToke)
        return  try await sigIn(credential: credential)
    }
    
    func sigIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResute = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResute.user)
    }
    
    @discardableResult
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
           let authDataResult = try await Auth.auth().signIn(with: credential)
           return AuthDataResultModel(user: authDataResult.user)
       }
    
}

//MARK: SIN IN Anonymousl

extension AuthenticationManger {
    
    @discardableResult
    func signInAnonymousl() async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
           return AuthDataResultModel(user: authDataResult.user)
       }
    
    func linkeEmail(email: String, passwored: String) async throws -> AuthDataResultModel {
        let credtion = EmailAuthProvider.credential(withEmail: email, password: passwored)
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        let auyDataReute = try await user.link(with: credtion)
        return AuthDataResultModel(user: auyDataReute.user)
    }
}

