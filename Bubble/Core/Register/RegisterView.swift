//
//  RegisterView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 13.10.2023.
//

import SwiftUI

struct RegisterView: View {
    @State private var showCreatAccount: Bool = false
    @Binding var showSingInView: Bool

    var body: some View {
        ZStack {
            VStack {
                if showCreatAccount == false {
                    SignIn(createAccount: $showCreatAccount, showSingInView: $showSingInView)
                        .transition(.move(edge: .leading))
                }
            }
            
             if showCreatAccount == true {
                 CreateAccountView(showSingInView: $showCreatAccount)
                     .transition(.move(edge: .trailing))
             }
          
        }
    }
}

#Preview {
    RegisterView(showSingInView: .constant(false))
}

