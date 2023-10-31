//
//  ProfilesHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 01.10.2023.
//

import SwiftUI

@MainActor
final class SettingsViewMode: ObservableObject {
    
    @Published var autProfiers: [AuthProviderOption] = []
    
    func loadAuthProvedr() {
        if let proveders = try? AuthenticationManger.shered.getProviders() {
            autProfiers = proveders
        }
    }
    
    func logOut() throws {
      try AuthenticationManger.shered.sigOut()
    }
    
    func delitesAccount() async throws {
        try await AuthenticationManger.shered.delete()
    }
   
    
    func resstPaswored() async throws {
        let autUser = try AuthenticationManger.shered.getAuthenticationUser()
        
        guard let email = autUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManger.shered.reestPaswored(email: email)
    }
    
    func updateEmail() async throws {
        let email = "hello1@testing.com"
        try await AuthenticationManger.shered.updateemail(email: email)
    }
    
    func updatePasswored() async throws {
        let paswored = "1234567"
        try await AuthenticationManger.shered.updatePaswwored(password: paswored)
    }
    
}



struct ProfilesHomeView: View {
    
    @StateObject var vmProfie = ProfilesViewMolde()
    
    @State private var showEdit: Bool = false
    @State private var showInfo: Bool = false
    @StateObject  var viewSigeIn = SigeInEmailViewMode()

    @State private var image = UIImage()
    @StateObject private var viewMolde = SettingsViewMode()
    @Binding var showSingView: Bool
    
    let colums:[GridItem] = [GridItem(.flexible()),GridItem(.flexible()),]
    @EnvironmentObject var vmMyPhoto : ViewModel
    
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
                        MyImagesList

                        if let user = vmProfie.user {
                            Text(user.uid)
                        }
                        Button(action: {
                            Task {
                                do {
                                    try viewMolde.logOut()
                                    showSingView = true
                                } catch {
                                    print(error)
                                }
                            }
                        }, label: {
                            Text("Login Out")
                                .font(.system(size: 17,weight: .semibold))
                                .padding(10)
                                .foregroundStyle(Color.them.ColorblackSwich)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(lineWidth: 1.0)
                                        .foregroundStyle(Color.them.ColorOrange)
                                )
                        })
                    }
                }
                .sheet(isPresented: $showInfo) {InfoView(vmProfie: vmProfie)}
                    
            }
            .task {
                if FileManager().docExist(named: fileName) {
                    vmMyPhoto.loadMyImagesJSONFile()
                }
            }
            .onAppear {
                vmProfie.loadImage(forKey: "imagePrilesKeySaved")
                vmProfie.retrieveText()
                try? vmProfie.loadCurrentUser()
            }
            
        }
    }
}

#Preview {
    ProfilesHomeView(showSingView: .constant(false))
        .environmentObject(ViewModel())
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
                        .onTapGesture {
                            showEdit.toggle()
                        }
                    
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
                    .font(.system(size: 22,weight: .regular))
                    .frame(width: 40,height: 40)
                    .background(Color.them.ColorBox)
                    .foregroundStyle(Color.them.ColorblackSwich)
                    .clipShape(.rect(cornerRadius: .infinity))
            }.padding()

        }
        .sheet(isPresented: $showEdit) {EditProfilesView()}
    }
    
    private var secionButtonEdit: some View {
        VStack {
            Text(vmProfie.userName)
                .font(.system(size: 18,weight: .semibold))
                .padding(.vertical,10)
            HStack {
                NavigationLink {
                    MyImagesHomeView()
                } label: {
                    Text("My Photo")
                        .font(.system(size: 15,weight: .semibold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.them.ColorBox)
                        .clipShape(.rect(cornerRadius: 12))
                }
               
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
    
    private var MyImagesList: some View {
        VStack {
            LazyVGrid(columns: colums){
                if vmMyPhoto.myImages.isEmpty {
                        ZStack(alignment: .bottom) {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                            
                            Text("add photo")
                                .font(.system(size: 15,weight: .semibold))
                                .foregroundStyle(Color.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        }
                        .frame(maxWidth: .infinity)
                            .frame(height: 180)
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 2))
                } else {
                    ForEach(vmMyPhoto.myImages.prefix(5)) { photo in
                        ZStack(alignment: .bottom) {
                            Image(uiImage: photo.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 190,height: 180)
                            
                            Text(photo.name)
                                .font(.system(size: 15,weight: .semibold))
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        }
                        .frame(height: 180)
                        .frame(maxWidth:.infinity)
                        .clipShape(.rect(cornerRadius: 2))
                    }
                }
            }
        }
    }
}

