//
//  CreateAccountView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 12.10.2023.
//

import SwiftUI
import Firebase

struct CreateAccountView: View {
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    @State private var showPassword = false

    init() {
        FirebaseApp.configure()
    }
    
    var body: some View {
        ZStack {
            FluidGradientViewColor()
            VStack {
                
                Spacer()
                
                titleWellcome
                
                SignInSectionTextFiled
                
                Spacer()
                Text(self.loginStatusMessage)
                    .foregroundColor(.red)
                VStack(alignment: .center, spacing: 16) {
                    Button(action: {createNewAccount()}){
                        ButtonCutemsLogin(title: "Create Account", background: Color.them.ColorBlue, foregroundStyle: Color.white)
                    }
                }.padding(.init(top: 56, leading: 0, bottom: 48, trailing: 0))
            }
        }
    }
    

        
        @State var loginStatusMessage = ""
        
        private func createNewAccount() {
            FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
                if let err = err {
                    print("Failed to create user:", err)
                    self.loginStatusMessage = "Failed to create user: \(err)"
                    return
                }
                
                print("Successfully created user: \(result?.user.uid ?? "")")
                
                self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            }
        }
}

#Preview {
    CreateAccountView()
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
                    TextField("Email", text: $email)
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
                        SecureField("Password", text: $password)
                            .font(.headline)
                            .keyboardType(.decimalPad)
                    } else {
                        TextField("Password", text: $password)
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

class FirebaseManager: NSObject {
    
    let auth: Auth
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        
        super.init()
    }
    
}
