//
//  ListFrindesChat.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 11.10.2023.
//

import SwiftUI

struct ListFrindesChat: View {
    var body: some View {
        ScrollView {
            ForEach(0..<1){ items in
                NavigationLink {
                    ChatView()
                } label: {
                    HStack {
                        Image("Avatar2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 55,height: 55)
                            .background(Color.pink.opacity(0.5))
                            .clipShape(.circle)
                            .foregroundStyle(Color.them.ColorBox)
                        VStack(alignment: .leading) {
                            Text("Chara")
                                .font(.system(size: 15,weight: .semibold))
                                .foregroundStyle(Color.them.ColorblackSwich)
                            Text("@cH782")
                                .font(.system(size: 15,weight: .regular))
                                .foregroundStyle(Color.gray)
                        }.padding(.leading,10)
                        Spacer()
                    }.padding(.horizontal)
                        .padding(.vertical,10)
                        .background(Color.them.ColorBox.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 22))
                        .padding(.horizontal)
                }
            }
        }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ListFrindesChat()
    }
}


