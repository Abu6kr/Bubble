//
//  FirendsDitelsView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 24.10.2023.
//

import SwiftUI

struct FirendsDitelsView: View {
    var body: some View {
        ZStack {
//            Color.them.Colorblack.ignoresSafeArea(.all)
            VStack {
                HStack {
                    Image("Avatar2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .padding(10)
                        .background(Color.green)
                        .clipShape(Circle())
                    
                    Text("Chara")
                        .font(.system(size: 18,weight: .regular))
                    Spacer()
                }.padding()
                Spacer()
            }
        }
    }
}

#Preview {
    FirendsDitelsView()
}
