//
//  MyImagesHomeView.swift
//  My Images
//
//  Created by Stewart Lynch on 2021-08-08.
//

import SwiftUI

struct MyImagesHomeView: View {
    @EnvironmentObject var vm: ViewModel
    @FocusState var nameField:Bool
    @StateObject var vmProfie = ProfilesViewMolde()
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [vmProfie.averageColor,Color.them.Colorblack,Color.them.Colorblack,Color.them.Colorblack,Color.them.Colorblack], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    ButtonBackward()
                    ScrollView {
                        VStack {
                            
                            if !vm.isEditing {
                                imageScroll
                            }
                        }
                        .task {
                            if FileManager().docExist(named: fileName) {
                                vm.loadMyImagesJSONFile()
                            }
                        }
                        .sheet(isPresented: $vm.showPicker) {
                            ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                                .ignoresSafeArea()
                        }
                        .alert("Error", isPresented: $vm.showFileAlert, presenting: vm.appError, actions: { cameraError in
                            cameraError.button
                        }, message: { cameraError in
                            Text(cameraError.message)
                        })
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                HStack {
                                    Spacer()
                                    Button {
                                        nameField = false
                                    } label : {
                                        Image(systemName: "keyboard.chevron.compact.down")
                                    }
                                }
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                    }

                }
                VStack {
                    Spacer()
                    NavigationLink {
                        selectedImage
                        VStack {
                            if vm.image != nil {
                                editGroup
                            }
                            if !vm.isEditing {
                                pickerButtons
                            }
                        }
                        .padding()
                    } label: {
                        HStack {
                            HStack {
                                Text("Add Your image")
                                    .font(.system(size: 15,weight: .bold))
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 22,weight: .semibold))
                            }
                            .padding(10)
                            .foregroundStyle(Color.them.ColorblackSwich)
                            .background(Color.them.Colorblack)
                            .clipShape(.rect(cornerRadius: 10))
                        }
                    
                    }   
                        .padding(.all)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15,weight: .regular))
                        .background(Color.them.ColorBox)
                        .cornerRadius(22, corners: [.topLeft,.topRight])
                        .padding(.bottom,20)
                        .frame(height: 100)
                    
                    
                }
            }
        }
        .onAppear {
            vmProfie.loadImage(forKey: "imagePrilesKeySaved")
        }
    }
}

struct MyImagesHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MyImagesHomeView()
            .environmentObject(ViewModel())
    }
}



