//
//  EditProfilesView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 02.10.2023.
//

import SwiftUI

struct EditProfilesView: View {
    @ObservedObject var vmProfie : ProfilesViewMolde
    
    @State private var name: String = ""
    @State private var userName: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [vmProfie.averageColor,vmProfie.averageColor.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .background(VisualEffect(style: .systemThickMaterial)).ignoresSafeArea(.all)

            ScrollView(showsIndicators: false){
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("nmae")
                        HStack {
                            Text(vmProfie.nameUser)
                                .font(.headline)
                            Spacer()
                        }
                    }.padding()
                        .frame(maxWidth: .infinity,maxHeight: 100)
                        .background(Color.them.ColorBox)
                        .cornerRadius(22, corners: [.topLeft, .topRight])
                        .cornerRadius(8, corners: [.bottomRight, .bottomLeft])
                        .padding(.horizontal)
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("user name")
                        HStack {
                            Text(vmProfie.userName)
                                .font(.headline)
                            Spacer()
                        }
                    }.padding()
                        .frame(maxWidth: .infinity,maxHeight: 100)
                        .background(Color.them.ColorBox)
                        .cornerRadius(22, corners: [.topLeft, .topRight])
                        .cornerRadius(8, corners: [.bottomRight, .bottomLeft])
                        .padding(.horizontal)
                    
                }.padding(.top,30)
            }
        }
        .onAppear{
            vmProfie.loadImage(forKey: "imagePrilesKeySaved")
            vmProfie.retrieveText()
        }
    }
}

#Preview {
    EditProfilesView(vmProfie: ProfilesViewMolde())
}
