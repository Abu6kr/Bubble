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
            FluidGradient(blobs: [vmProfie.averageColor.opacity(0.5)]).ignoresSafeArea(.all)
            ScrollView(showsIndicators: false){
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("nmae")
                        HStack {
                            TextField("name", text: $vmProfie.nameUser)
                                .font(.headline)
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
                            TextField("user name", text: $vmProfie.userName)
                                .font(.headline)
                        }
                    }.padding()
                        .frame(maxWidth: .infinity,maxHeight: 100)
                        .background(Color.them.ColorBox)
                        .cornerRadius(22, corners: [.topLeft, .topRight])
                        .cornerRadius(8, corners: [.bottomRight, .bottomLeft])
                        .padding(.horizontal)
                    
                }.padding(.top)
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
