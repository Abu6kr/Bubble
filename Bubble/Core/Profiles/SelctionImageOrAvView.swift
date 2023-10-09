//
//  SelctionImageOrAvView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 09.10.2023.
//

import SwiftUI

struct SelctionImageOrAvView: View {
    
    @StateObject var vmProfile = ProfilesViewMolde()
    
    @State var showAvar: Bool = false
    @State var showImages: Bool = false
    
    @State private var avaters: [Image] = []
    @State var avatersData : Data = .init(count: 0)

    
    var body: some View {
        NavigationStack {
            ZStack {
                FluidGradientViewColor()
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        switch vmProfile.SectionImages {
                        case .images:
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
                        case .avater:
                            Image(vmProfile.avaer.first ?? "")
                        }
                        
                        
                        VStack(alignment: .center,spacing: 22) {
                            
                            Text("Image")
                                .font(.system(size: 18,weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.them.ColorBox)
                                .foregroundStyle(Color.them.ColorblackSwich)
                                .clipShape(.rect(cornerRadius: 30))
                                .shadow(color: .black.opacity(0.03), radius: 5)
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation(.easeInOut){
                                        showImages.toggle()
                                        vmProfile.SectionImages = .images
                                    }
                                }
                                .fullScreenCover(isPresented: $showImages) {ImagesSectionView()}
                            
                            Text("Avatar")
                                .font(.system(size: 18,weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.them.ColorBox)
                                .foregroundStyle(Color.them.ColorblackSwich)
                                .clipShape(.rect(cornerRadius: 30))
                                .shadow(color: .black.opacity(0.03), radius: 5)
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation(.easeInOut){
                                        showAvar.toggle()
                                        vmProfile.SectionImages  = .avater
                                    }
                                }
                                .fullScreenCover(isPresented: $showAvar) {AvatersView()}
                            
                        }.padding(.top,50)
                    }.padding(.top)
                }
            }
            .onAppear {
                vmProfile.loadImage(forKey: "imagePrilesKeySaved")
                vmProfile.iterateOverAuthors(authors: vmProfile.avaer)
            }
            .navigationTitle("Image or Avatar")
            
        }
    }
}

#Preview {
    SelctionImageOrAvView()
}


