//
//  ChatTopBar.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 11.10.2023.
//

import SwiftUI

struct ChatTopBar: View {
    @StateObject var vmProfie: ProfilesViewMolde
    var body: some View {
        VStack {
            HStack {
                if let image = vmProfie.imageProfiles {
                   Image(uiImage: image)
                        .resizable()
                        .frame(width: 50,height: 50)
                        .background(Color.red)
                        .clipShape(.circle)
                }
                Spacer()
                Text("Chat")
                    .font(.system(size: 18,weight: .bold))
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 18,weight: .semibold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                })
               
            }.padding(.horizontal)
        }
        .onAppear {
            vmProfie.loadImage(forKey: "imagePrilesKeySaved")
        }
    }
}

#Preview {
    ChatTopBar(vmProfie: ProfilesViewMolde())
}
