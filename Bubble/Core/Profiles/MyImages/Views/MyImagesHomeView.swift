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
    var body: some View {
        VStack {
            ButtonBackward()
            ScrollView {
                VStack {
                    
                    if !vm.isEditing {
                        imageScroll
                    }
                    
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
    }
}

struct MyImagesHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MyImagesHomeView()
            .environmentObject(ViewModel())
    }
}



