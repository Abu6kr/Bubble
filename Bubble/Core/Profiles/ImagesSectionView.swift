//
//  ImagesSectionView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 09.10.2023.
//

import SwiftUI

struct ImagesSectionView: View {
    @StateObject var vmProfile = ProfilesViewMolde()
    
    @State private var showImagePicker = false
    @State private var image = UIImage()
    @State  var sectionAvater: Bool = false
    
    @Environment(\.dismiss) var  dismiss
    
    var body: some View {
        ZStack {
            FluidGradient(blobs: [vmProfile.averageColor]).ignoresSafeArea(.all)
                .background(VisualEffect(style: .systemThickMaterial)).ignoresSafeArea(.all)
                .opacity(0.5)
            
            ScrollView {
                VStack {
                    ButtonDismiss(dismiss: _dismiss)
                    //MARK: SECTION Photo
                    Button(action: {
                        self.showImagePicker = true
                    }) {
                        if let image =  vmProfile.imageProfiles  {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity,maxHeight: 250)
                                .background(VisualEffect(style: .systemThickMaterial))
                                .clipShape(.rect(cornerRadius: 30))
                                .shadow(color: Color.them.ColorblackSwich.opacity(0.05), radius: 30)
                                .padding(.horizontal,16)
                            
                        } else if vmProfile.imageProfiles == nil {
                            
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 25,height: 25)
                                .foregroundStyle(Color.them.ColorblackSwich)
                                .frame(maxWidth: .infinity,maxHeight: 250)
                                .background(VisualEffect(style: .systemThickMaterial))
                                .clipShape(.rect(cornerRadius: 30))
                                .shadow(color: Color.them.ColorblackSwich.opacity(0.05), radius: 30)
                                .padding(.horizontal,16)
                        }
                        
                    }.padding(.top,30)
                    
                    Button(action: {
                        vmProfile.saveImage(imageName: "imagePrilesKeySaved", image: image, key: "imagePrilesKeySaved")
                        vmProfile.saveInfo()
                        dismiss()
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
    ImagesSectionView()
}
