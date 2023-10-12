//
//  SignInGoogleHelper.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 30.09.2023.
//


import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogesSignInResultMolde {
    let idToke: String
    let accesToke: String
    let name: String?
    let email: String?
}

final class SiginGoogelHelper {
    
    @MainActor
    func singIn() async throws -> GoogesSignInResultMolde {
        guard let topVC = Utilites.sherd.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSignInRessul = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        
        guard let idToken: String = gidSignInRessul.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let acceasToke: String = gidSignInRessul.user.accessToken.tokenString
        
        let accessToken = gidSignInRessul.user.accessToken.tokenString
        let name = gidSignInRessul.user.profile?.name
        let email = gidSignInRessul.user.profile?.email
        
        let tokens = GoogesSignInResultMolde(idToke: idToken, accesToke: acceasToke, name: name, email: email)
        return tokens
    }
}
