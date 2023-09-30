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
    
    @State private var showPoop = false
    
    @State var swictPopView: PopupView = .Error
    
    var body: some View {
        ZStack {
            FluidGradientViewColor()
            
            ScrollView(showsIndicators: false) {
             
                ButtonDismiss()
              
                titleWellcome
                    .padding(.top,28)
                signInMethod
                    .padding(.top,30)
                
                Button(action: {
                    withAnimation(.easeInOut){
                        showPoop.toggle()
                    }
                }) {
                    ButtonCutemsLogin(title: "LogIn", background: Color.them.ColorBlue, foregroundStyle: Color.white)
                }.padding(.top,20)
                
            }
            
            if showPoop {
                withAnimation(.snappy){
                    switch swictPopView {
                    case .SuccessFully:
                        PopupCutemsView(colorFluidGradient: Color.green,dismiss: $showPoop, title: "Successfully", discrip: "Yahoo! You have successfully verified the account.")
                    case .VerifyEmail:
                        PopupCutemsView(colorFluidGradient: Color.them.ColorBlue,dismiss: $showPoop, title: "Verify email", discrip: "Please enter the 4 digit code sent to yourmail@example.com")
                    case .Error:
                        PopupCutemsView(colorFluidGradient: Color.red,dismiss: $showPoop, title: "Error", discrip: "Somting You have error")
                    }
                }
            }
        }
    }
}

#Preview {
    SignInMethodGoogleView()
}













extension SignInMethodGoogleView {
    
    private var titleWellcome: some View {
        VStack(alignment: .center,spacing: 10){
            Text("Wellcome!")
                .font(.system(size: 15,weight: .regular))
            Text("Sign in")
                .font(.system(size: 25,weight: .bold))
            Text("Select method")
                .font(.system(size: 15,weight: .regular))
                .foregroundStyle(Color.gray)
        }
    }
    
    private var signInMethod: some View {
        VStack(spacing: 12) {
            Button(action: {
                withAnimation(.easeInOut){
                    sectionLoginApple.toggle()
                    if sectionLoginApple == true {
                        sectionLoginGoogle = false
                        sectionLoginFacebook = false
                    }
                }
               
            }){
                SignInMethodGoogle(sectionLogin: $sectionLoginApple, icpne: "Apple", nameSignIn: "Apple")
                
            }
            Button(action: {
                withAnimation(.easeInOut){
                    sectionLoginFacebook.toggle()
                    if sectionLoginFacebook == true {
                        sectionLoginGoogle = false
                        sectionLoginApple = false
                    }
                }
            }){
                SignInMethodGoogle(sectionLogin: $sectionLoginFacebook, icpne: "Facebook", nameSignIn: "Facebook")
            }
            
            Button(action: {
                withAnimation(.easeInOut){
                    sectionLoginGoogle.toggle()
                    if sectionLoginGoogle == true {
                        sectionLoginFacebook = false
                        sectionLoginApple = false
                    }
                }
            }){
                SignInMethodGoogle(sectionLogin: $sectionLoginGoogle, icpne: "Google", nameSignIn: "Google")
            }
         
        }
    }
    
    
}
