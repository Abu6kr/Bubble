//
//  ProfilesHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 01.10.2023.
//

import SwiftUI

struct ProfilesHomeView: View {
    
    @StateObject var vmProfie = ProfilesViewMolde()
    @State private var showEdit: Bool = true
    
    @State private var showImagePicker = false
    @State private var image = UIImage()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [vmProfie.averageColor,vmProfie.averageColor.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    imageSection
                    Spacer()
                }
                .sheet(isPresented: $showEdit, content: {
                    EditProfilesView(vmProfie: vmProfie)
                        .presentationDetents([.height(250), .medium])
                        .presentationBackgroundInteraction(.enabled(upThrough: .height(250)))
                })
                    
            }
            .onAppear {
                vmProfie.loadImage(forKey: "imagePrilesKeySaved")
                vmProfie.retrieveText()
                if showImagePicker == false {
                    showEdit = true
                } else {
                    showEdit = false
                }
            }
        }
    }
}

#Preview {
    ProfilesHomeView()
}


extension ProfilesHomeView {
    
    private var imageSection: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                if let image =  vmProfie.imageProfiles  {
                    Image(uiImage: image)
                        .resizable()
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .background(Color.them.ColorBox)
                        .clipShape(.rect(cornerRadius: 12))
                    
                } else if vmProfie.imageProfiles == nil {
                    Image(systemName: "pencil")
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .background(Color.them.ColorBox)
                        .clipShape(.rect(cornerRadius: 12))
                }
            }
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
//            }
            Button(action: {showImagePicker.toggle()}){
                Image(systemName: "pencil")
                    .padding(10)
                    .background(Color.them.ColorBox)
                    .foregroundStyle(Color.them.ColorblackSwich)
                    .clipShape(.rect(cornerRadius: .infinity))
                    .padding()
            }.sheet(isPresented: $showImagePicker) {
                AvatarView()
            }
        }
    }
    
}

