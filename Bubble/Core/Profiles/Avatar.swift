//
//  Avatar.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 27.09.2023.
//

import SwiftUI

struct AvatarView: View {
    
    @StateObject var vmProfile = ProfilesViewMolde()
    @State private var showImagePicker = false
    @State private var image = UIImage()
    @State  var sectionAvater: Bool = false


    var body: some View {
        ZStack {
            FluidGradient(blobs: [Color.blue,Color.blue.opacity(0.5)]).ignoresSafeArea(.all)
                .background(VisualEffect(style: .systemThickMaterial)).ignoresSafeArea(.all)
                .opacity(0.5)
            VStack {
                
                //MARK: SECTION Avatar
                VStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: vmProfile.colums){
                            ForEach(avatarMolde){ avatar in
                                Avatar(sectionAvater: $sectionAvater, avtar: avatar)
                                 
                            }
                        }.padding()
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(VisualEffect(style: .systemThickMaterial))
                .clipShape(.rect(cornerRadius: 30))
                .shadow(color: Color.them.ColorblackSwich.opacity(0.05), radius: 30)
                .padding(.horizontal)
                
                //MARK: SECTION Photo
                Button(action: {
                    self.showImagePicker = true
                }) {
                    if vmProfile.imageProfiles != nil {
                        Image(uiImage: image)
                            .resizable()
                            .frame(maxWidth: .infinity,maxHeight: 250)
                            .background(VisualEffect(style: .systemThickMaterial))
                            .clipShape(.rect(cornerRadius: 30))
                            .shadow(color: Color.them.ColorblackSwich.opacity(0.05), radius: 30)
                            .padding(.horizontal,16)
                    } else {
                        Image(uiImage: image)
                            .resizable()
                            .frame(maxWidth: .infinity,maxHeight: 250)
                            .background(VisualEffect(style: .systemThickMaterial))
                            .clipShape(.rect(cornerRadius: 30))
                            .shadow(color: Color.them.ColorblackSwich.opacity(0.05), radius: 30)
                            .padding(.horizontal,16)
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
        }
    }
}

#Preview {
    AvatarView()
}


struct Avatar: View {
    @Binding var sectionAvater: Bool
    let avtar: AvatarMolde
    var body: some View {
        Image(avtar.Avatar)
            .resizable()
            .scaledToFill()
            .frame(width: 100,height: 100)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(sectionAvater ? Color.red : Color.white)
            )
            .background(VisualEffect(style: .prominent))
            .clipShape(.rect(cornerRadius: 30))
    }
}


struct AvatarMolde: Identifiable {
    let id = UUID().uuidString
    let Avatar: String
}
 
let avatarMolde: [AvatarMolde] = [
    AvatarMolde(Avatar: "Avatar1"),
    AvatarMolde(Avatar: "Avatar2"),
    AvatarMolde(Avatar: "Avatar3"),
    
]
