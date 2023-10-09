//
//  ProfilesHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 01.10.2023.
//

import SwiftUI

struct ProfilesHomeView: View {
    
    @StateObject var vmProfie = ProfilesViewMolde()
    
    @State private var showEdit: Bool = false
    @State private var showInfo: Bool = false
    
    @State private var image = UIImage()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [vmProfie.averageColor,vmProfie.averageColor.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        
                        ButtonEdit
                        
                        imageSection
                        
                        secionButtonEdit
                     
                    }
                }
                .sheet(isPresented: $showInfo) {InfoView(vmProfie: vmProfie)}
                    
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
                        .scaledToFill()
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                        .background(Color.them.ColorBox)
                        .clipShape(.circle)
                        .padding(.horizontal)
                    
                } else if vmProfie.imageProfiles == nil {
                    Image(systemName: "pencil")
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                        .background(Color.them.ColorBox)
                        .clipShape(.circle)
                }
            }
        }
    }
    private var ButtonEdit: some View {
        HStack {
            Spacer()
            Button(action: {showEdit.toggle()}){
                Image(systemName: "pencil")
                    .padding(10)
                    .background(Color.them.ColorBox)
                    .foregroundStyle(Color.them.ColorblackSwich)
                    .clipShape(.rect(cornerRadius: .infinity))
                    .padding()
            }
        }
        .sheet(isPresented: $showEdit) {EditProfilesView()}
    }
    
    private var secionButtonEdit: some View {
        VStack {
            Text(vmProfie.userName)
                .font(.system(size: 18,weight: .semibold))
                .padding(.vertical,10)
            HStack {
                Button(action: {}, label: {
                    Text("My Photo")
                        .font(.system(size: 15,weight: .semibold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.them.ColorBox)
                        .clipShape(.rect(cornerRadius: 12))
                })
               
                Spacer()
                Button(action: {
                    showInfo.toggle()
                }, label: {
                    Text("Info")
                        .font(.system(size: 15,weight: .semibold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.them.ColorBox)
                        .clipShape(.rect(cornerRadius: 12))
                })
             
            }.padding(.all)
        }
    }
    
}

