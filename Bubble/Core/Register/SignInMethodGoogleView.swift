//
//  SignInMethodGoogleView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 28.09.2023.
//

import SwiftUI

struct SignInMethodGoogleView: View {
    
    @State private var sectionLoginApple: Bool = false
    @State private var sectionLoginFacebook: Bool = false
    @State private var sectionLoginGoogle: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
                FluidGradientViewColor()
            ScrollView(showsIndicators: false) {
               
                VStack(spacing: 12) {
                    Button(action: {dismiss()}){
                        HStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .font(.system(size: 18,weight: .regular))
                                .foregroundStyle(Color.them.ColorblackSwich)
                        }
                    }.padding(.horizontal)
                    
                    Button(action: {
                        sectionLoginApple.toggle()
                        if sectionLoginApple == true {
                            sectionLoginGoogle = false
                            sectionLoginFacebook = false
                        }
                    }){
                        SignInMethodGoogle(sectionLogin: $sectionLoginApple, icpne: "Apple", nameSignIn: "Apple")
                        
                    }
                    Button(action: {
                        sectionLoginFacebook.toggle()
                        if sectionLoginFacebook == true {
                            sectionLoginGoogle = false
                            sectionLoginApple = false
                        }
                    }){
                        SignInMethodGoogle(sectionLogin: $sectionLoginFacebook, icpne: "Facebook", nameSignIn: "Facebook")
                    }
                    
                    Button(action: {
                        sectionLoginGoogle.toggle()
                        if sectionLoginGoogle == true {
                            sectionLoginFacebook = false
                            sectionLoginApple = false
                        }
                    }){
                        SignInMethodGoogle(sectionLogin: $sectionLoginGoogle, icpne: "Google", nameSignIn: "Google")
                    }
                    
                    Button(action: {
                        
                    }) {
                        ButtonCutemsLogin(title: "LogIn", background: Color.them.ColorBlue, foregroundStyle: Color.white)
                    }.padding(.top)
                }.padding(.top,22)
            }
        }
    }
}

#Preview {
    SignInMethodGoogleView()
}

