//
//  SignInMethodGoogle.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 28.09.2023.
//

import SwiftUI

struct SignInMethodGoogle: View {
    
    let userUse: String = "Use"
    @Binding var sectionLogin: Bool
    
    let icpne: String
    let nameSignIn: String
    
    var body: some View {
        HStack {
            Image(icpne)
                .resizable()
                .scaledToFit()
                .frame(width: 20,height: 20)
                .frame(width: 56, height: 56)
                .background(sectionLogin ? Color.them.ColorBlue : Color.gray.opacity(0.3))
                .clipShape(.rect(cornerRadius: .infinity))
                .padding(.horizontal)
            VStack(alignment: .leading) {
                if sectionLogin == true {
                    Text(userUse)
                        .font(.system(size: 15,weight: .regular))
                        .foregroundStyle(Color.gray)
                }
                Text(nameSignIn)
                    .font(.system(size: 20,weight: .bold))
                    .foregroundStyle(Color.white)
            }
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 56,height: 56)
                    .foregroundStyle(Color.gray.opacity(0.3))

         
                RoundedRectangle(cornerRadius: .infinity)
                    .stroke(lineWidth: 1)
                    .frame(width: 19,height: 19)
                    .foregroundColor(sectionLogin ? Color.them.ColorBlue : Color.gray)

                Circle()
                    .frame(width: 12,height: 12)
                    .foregroundColor(sectionLogin ? Color.them.ColorBlue : Color.clear)
                
            }.padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 104)
        .background(
            RoundedRectangle(cornerRadius: .infinity)
                .stroke(lineWidth:sectionLogin ? 4 : 400)
                .foregroundStyle(sectionLogin ? Color.them.ColorBlue.opacity(0.2) : Color.them.ColorBox)
        )
        .clipShape(.rect(cornerRadius: .infinity))
        .shadow(color: Color.them.ColorblackSwich.opacity(0.1), radius: 60)
        .padding(.horizontal)

    }
}

#Preview {
    SignInMethodGoogle(sectionLogin: .constant(false), icpne: "Apple", nameSignIn: "Apple")
        .previewLayout(.sizeThatFits)
}
