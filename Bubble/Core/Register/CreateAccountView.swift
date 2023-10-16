//
//  CreateAccountView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 12.10.2023.
//

import SwiftUI
import Firebase

struct CreateAccountView: View {
    
    @StateObject  var viewMolde = SigeInEmailViewMode()
    @State private var showPassword = false
    @Binding var showSingInView: Bool
    
    var body: some View {
        ZStack {
            FluidGradientViewColor()
            VStack {
                Button {
                    withAnimation(.easeInOut) {
                        showSingInView.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18,weight: .semibold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                }.frame(maxWidth: .infinity,alignment: .trailing)
                    .padding(.horizontal)
                Spacer()

                titleWellcome
                
                SignInSectionTextFiled
                
                Spacer()
                
                VStack(alignment: .center, spacing: 16) {
                    Button(action: {
                        Task {
                            do {
                                try await viewMolde.signInAnones()
                                showSingInView = false
                                return
                            } catch {
                                print(error)
                            }                         
                        }
                    }){
                        ButtonCutemsLogin(title: "Create Account", background: Color.them.ColorBlue, foregroundStyle: Color.white)
                    }
                }.padding(.init(top: 56, leading: 0, bottom: 48, trailing: 0))
            }
        }
    }

}

#Preview {
    CreateAccountView(showSingInView: .constant(false))
}



extension CreateAccountView {
    
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



import Foundation

final class SigeInEmailViewMode: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    
    func signUp() async throws {
        guard !email.isEmpty,!password.isEmpty else {
            print("No emill or passwored foned")
            return
        }
        let authDataeReutts = try await AuthenticationManger.shered.creatUser(email: email, password: password)
        try await UserManger.shered.createNewUser(auth: authDataeReutts)
    }
    
    func signIn() async throws {
        guard !email.isEmpty,!password.isEmpty else {
            print("No emill or passwored foned")
            return
        }
        try await AuthenticationManger.shered.signInUser(email: email, password: password)
    }
    func signInAnones() async throws {
        let autDataRestes = try await AuthenticationManger.shered.signInUser(email: email, password: password)
        try await UserManger.shered.createNewUser(auth: autDataRestes)
    }
}
