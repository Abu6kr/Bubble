//
//  ContentView+Extension.swift
//  ContentView+Extension
//
//  Created by Stewart Lynch on 2021-08-18.
//

import SwiftUI

extension MyImagesHomeView {
    var imageScroll: some View {
        LazyVGrid(columns: vm.colums){
                ForEach(vm.myImages) { myImage in
                    VStack {
                        ZStack(alignment: .bottom) {
                            Image(uiImage: myImage.image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .frame(height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            Text(myImage.name)
                                .lineLimit(1)
                                .font(.system(size: 16,weight: .semibold))
                        }
                    }.padding(.horizontal)
                    .onTapGesture {
                        vm.display(myImage)
                    }
                    
                }
            }.padding(.leading)
    }
    
    var selectedImage: some View {
        Group {
            if let image = vm.image {
                ZoomableScrollView {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.horizontal)
            }
        }
    }
    
    var editGroup: some View {
        Group {
            TextField("Image Name", text: $vm.imageName) { isEditing in
                vm.isEditing = isEditing
            }
            .focused($nameField, equals: true)
            .textFieldStyle(.roundedBorder)
            HStack {
                Button {
                    if vm.selectedImage == nil {
                        vm.addMyImage(vm.imageName, image: vm.image!)
                    } else {
                        vm.updateSelected()
                        nameField = false
                    }
                } label: {
                    ButtonLabel(symbolName: vm.selectedImage == nil ? "square.and.arrow.down.fill" : "square.and.arrow.up.fill",
                                label: vm.selectedImage == nil ? "Save" : "Update")
                }
                .disabled(vm.buttonDisabled)
                .opacity(vm.buttonDisabled ? 0.6 : 1)
                if !vm.deleteButtonIsHidden {
                    Button {
                        vm.deleteSelected()
                    } label: {
                        ButtonLabel(symbolName: "trash", label: "Delete")
                    }
                }
            }
        }
    }
    
    var pickerButtons: some View {
        HStack {
            Button {
                vm.source = .camera
                vm.showPhotoPicker()
            } label: {
                ButtonLabel(symbolName: "camera", label: "Camera")
            }
            .alert("Error", isPresented: $vm.showCameraAlert, presenting: vm.cameraError, actions: { cameraError in
                cameraError.button
            }, message: { cameraError in
                Text(cameraError.message)
            })
            Button {
                vm.source = .library
                vm.showPhotoPicker()
            } label: {
                ButtonLabel(symbolName: "photo", label: "Photos")
            }
        }
    }
}
