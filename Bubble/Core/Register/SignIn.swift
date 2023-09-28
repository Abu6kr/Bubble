//
//  SignIn.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 27.09.2023.
//

import SwiftUI

struct SignIn: View {
    
    @State private var Email: String = ""
    @State private var Password: String = ""
    @State private var showPassword = false
    @State private var showSingWitheGoogle: Bool = false
    
    var body: some View {
        ZStack {
            FluidGradientViewColor()
            VStack {
                
                Spacer()
                
                titleWellcome
                
                SignInSectionTextFiled
                
                Spacer()
                
                VStack(alignment: .center, spacing: 16) {
                    Button(action: {}){
                        ButtonCutemsLogin(title: "Sign in now", background: Color.them.ColorBlue, foregroundStyle: Color.white)
                    }
                   
                    Button(action: {}){
                        ButtonCutemsLogin(title: "Sign up", background: Color.clear, foregroundStyle: Color.them.ColorblackSwich)
                    }
                  
                }.padding(.init(top: 56, leading: 0, bottom: 48, trailing: 0))
                
                Button(action: {self.showSingWitheGoogle.toggle()}) {
                    Text("Select method")
                }.sheet(isPresented: $showSingWitheGoogle){SignInMethodGoogleView().presentationDetents([.medium, .fraction(0.6)])}
            }
        }
    }
}

#Preview {
    SignIn()
}









extension SignIn {
    
    private var titleWellcome: some View {
        VStack(alignment: .center,spacing: 10){
            Text("Wellcome!")
                .font(.system(size: 15,weight: .regular))
            Text("Sign in")
                .font(.system(size: 25,weight: .bold))
            Text("Please fill your informations")
                .font(.system(size: 15,weight: .regular))
                .foregroundStyle(Color.gray)
        }
    }
    
    private var SignInSectionTextFiled: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Email")
                HStack {
                    TextField("Email", text: $Email)
                        .font(.headline)
                    Image(systemName: "envelope")
                        .foregroundStyle(Color.them.ColorblackSwich)
                    
                }
            }.padding()
                .frame(maxWidth: .infinity,maxHeight: 100)
                .background(Color.them.ColorBox)
                .cornerRadius(22, corners: [.topLeft, .topRight])
                .cornerRadius(8, corners: [.bottomRight, .bottomLeft])
                .padding(.horizontal)
            
            
            VStack(alignment: .leading) {
                Text("Password")
                HStack {
                    if !showPassword {
                        SecureField("Password", text: $Password)
                            .font(.headline)
                            .keyboardType(.decimalPad)
                    } else {
                        TextField("Password", text: $Password)
                            .font(.headline)
                            .keyboardType(.decimalPad)
                    }
                    Button(action: {
                        withAnimation(.easeInOut){showPassword.toggle()}}){
                            Image(systemName: showPassword ? "lock.open.fill" : "lock.fill")
                                .foregroundStyle(Color.them.ColorblackSwich)
                        }
                }
            }.padding()
                .frame(maxWidth: .infinity,maxHeight: 100)
                .background(Color.them.ColorBox)
                .cornerRadius(22, corners: [.topLeft, .topRight])
                .cornerRadius(8, corners: [.bottomRight, .bottomLeft])
                .padding(.horizontal)
        }.padding(.top,46)

    }
    
}



