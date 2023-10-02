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
            FluidGradient(blobs: [vmProfile.averageColor]).ignoresSafeArea(.all)
                .background(VisualEffect(style: .systemThickMaterial)).ignoresSafeArea(.all)
                .opacity(0.5)
            ScrollView {
                VStack {
                    
                    //MARK: SECTION Photo
                    Button(action: {
                        self.showImagePicker = true
                    }) {
                        if let image =  vmProfile.imageProfiles  {
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
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("nmae")
                            HStack {
                                TextField("name", text: $vmProfile.nameUser)
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
                                TextField("user name", text: $vmProfile.userName)
                                    .font(.headline)
                                
                            }
                        }.padding()
                            .frame(maxWidth: .infinity,maxHeight: 100)
                            .background(Color.them.ColorBox)
                            .cornerRadius(22, corners: [.topLeft, .topRight])
                            .cornerRadius(8, corners: [.bottomRight, .bottomLeft])
                            .padding(.horizontal)
                        
                    }
                    .padding(.top)
                    
                    Button(action: {
                        vmProfile.saveImage(imageName: "imagePrilesKeySaved", image: image, key: "imagePrilesKeySaved")
                        vmProfile.saveInfo()
                    }){
                        ButtonCutemsLogin(title: "Save", background: Color.them.ColorBox.opacity(0.8), foregroundStyle: Color.them.ColorblackSwich)
                    }.padding(.top)
                    
                }.padding(.top)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
                .onAppear {
                    vmProfile.loadImage(forKey: "imagePrilesKeySaved")
                    NotificationCenter.default.post(name: .saveVenueProfileImage, object: nil)
                    vmProfile.retrieveText()
                    
                }
            }
        }
        
    }
}

#Preview {
    AvatarView()
}
