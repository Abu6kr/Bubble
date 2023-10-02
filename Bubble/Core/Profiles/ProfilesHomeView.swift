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
                FluidGradient(blobs: [vmProfie.averageColor.opacity(0.5)]).ignoresSafeArea(.all)
                VStack {
                    imageSection
                    Spacer()
                }
                
                EditProfilesView(vmProfie: vmProfie)
                    .background(FluidGradient(blobs: [vmProfie.averageColor.opacity(0.5)]))
                    .frame(height: 500)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(22, corners: [.topLeft,.topRight])
                    .offset(y: 250).ignoresSafeArea()
                
            }
            .onAppear {
                vmProfie.loadImage(forKey: "imagePrilesKeySaved")
                vmProfie.retrieveText()
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