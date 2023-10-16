//
//  SignIn.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 27.09.2023.
//

import SwiftUI

struct SignIn: View {
    
    @State private var showPassword = false
    @State private var showSingWitheGoogle: Bool = false
    
    @Binding  var createAccount: Bool
    @Binding var showSingInView: Bool

    @StateObject  var viewMolde = SigeInEmailViewMode()

    var body: some View {
        ZStack {
            FluidGradientViewColor()
            VStack {
                
                Spacer()
                
                titleWellcome
                SignInSectionTextFiled
                
                Spacer()
                
                VStack(alignment: .center, spacing: 16) {
                    Button(action: {
                        Task {
                            do {
                                try await viewMolde.signIn()
                                showSingInView = false
                                return
                            } catch {
                                print(error)
                            }
                        }
                    }){
                        ButtonCutemsLogin(title: "Sign in now", background: Color.them.ColorBlue, foregroundStyle: Color.white)
                    }
                    HStack(spacing: 5) {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                self.createAccount.toggle()
                            }
                        }){
                            ButtonCutemsLogin(title: "Create Account", background: Color.clear, foregroundStyle: Color.them.ColorblackSwich)
                        }
                        Button(action: {self.showSingWitheGoogle.toggle()}) {
                            ButtonCutemsLogin(title: "Select Method", background: Color.clear, foregroundStyle: Color.them.ColorblackSwich)
                        }

                    }
                }.padding(.init(top: 56, leading: 0, bottom: 48, trailing: 0))
                    .sheet(isPresented: $showSingWitheGoogle){
                        SignInMethodGoogleView().presentationDetents([.fraction(0.9),.medium])
                    }
            }
        }
    }
}

#Preview {
    SignIn(createAccount: .constant(false), showSingInView: .constant(false))
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
                    TextField("Email", text: $viewMolde.email)
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
                        SecureField("Password", text: $viewMolde.password)
                            .font(.headline)
                            .keyboardType(.decimalPad)
                    } else {
                        TextField("Password", text: $viewMolde.password)
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



