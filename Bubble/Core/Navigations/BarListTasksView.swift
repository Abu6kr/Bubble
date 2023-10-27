//
//  BarListTasksView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.10.2023.
//

import SwiftUI

struct BarListTasksView: View {
    
    @State  var showBar = true
    @Binding var showCamera: Bool
    @Binding var showShazam: Bool
    @Binding var showContact: Bool
    
    @ObservedObject var vmMap : MapMoldeView
    @EnvironmentObject var vm: ViewModel
    @FocusState var nameField:Bool
    
    @State private var showimages: Bool = false
    var body: some View {
        VStack {
       
            VStack(alignment: .center,spacing: 22) {
                Button(action: {
                    showCamera.toggle()
                    if showCamera == true {
                        vm.source = .camera
                        vm.showPhotoPicker()
                        showimages = true
                    }
                }) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                }
             
                if !showBar {
                    Button(action: {
                        withAnimation(.smooth){self.vmMap.toggleMapStyle()}
                    }) {
                        switch vmMap.mapStyleSelection {
                        case .standard:
                            Image(systemName: "map.fill")
                        case .hybrid:
                            Image(systemName: "mappin.and.ellipse")
                        case .imagery:
                            Image(systemName: "mappin.slash.circle")
                        }
                    }
                    Button(action: {showShazam.toggle()}) {
                        Image(systemName: "shazam.logo.fill")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(Color.them.ColorblackSwich)
                    }
                    Button(action: {self.showContact.toggle()}) {
                        Image(systemName: "person.crop.rectangle.badge.plus.fill")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(Color.them.ColorblackSwich)
                    }.fullScreenCover(isPresented: $showContact){
                        ContactsView(dismiss: $showContact)
                    }
                }
        
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showBar.toggle()
                    }
                }, label: {
                    Image(systemName: showBar ? "chevron.down" : "chevron.up")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                })
               
            }
        }
        .frame(width: 20)
        .padding()
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: .infinity))
        .shadow(color: .black.opacity(0.05), radius: 10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.leading,10)
        .task {
            if FileManager().docExist(named: fileName) {
                vm.loadMyImagesJSONFile()
            }
        }
        .fullScreenCover(isPresented: $vm.showPicker) {
            ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                .ignoresSafeArea()
        }
        .alert("Error", isPresented: $vm.showFileAlert, presenting: vm.appError, actions: { cameraError in
            cameraError.button
        }, message: { cameraError in
            Text(cameraError.message)
        })
        .sheet(isPresented: $showimages) {
            camerPhoto
                .presentationDetents([.height(250)])
                .presentationCornerRadius(12)
        }
      
        
    }
}

struct BarListTasksView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
//            Color.white.ignoresSafeArea()
            BarListTasksView(showCamera: .constant(false), showShazam: .constant(false), showContact: .constant(false), vmMap: MapMoldeView())
                .environmentObject(ViewModel())
                .previewLayout(.sizeThatFits)
        }
    }
}

struct moldeBarList: Identifiable {
    let id = UUID().uuidString
    let systemName: String
    
}

extension BarListTasksView {
    
    private var camerPhoto: some View {
        VStack(alignment: .center, spacing: 22) {
 
            Button(action: {showimages.toggle()}){
                HStack {
                    Text("Expressed Image")
                        .font(.system(size: 18,weight: .bold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 18,weight: .semibold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                }
            }.padding(.horizontal)
            TextField("Image Name", text: $vm.imageName) { isEditing in
                vm.isEditing = isEditing
            }
            .padding(.horizontal)
            .focused($nameField, equals: true)
            .frame(height: 40)
            .frame(maxWidth:.infinity)
            .background(Color.them.ColorBox)
            
            HStack {
                Button {
                    if vm.selectedImage == nil {
                        vm.addMyImage(vm.imageName, image: vm.image!)
                        showimages = false

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
                    HStack {
                        Button {
                            vm.deleteSelected()
                        } label: {
                            ButtonLabel(symbolName: "trash", label: "Delete")
                        }
                        Button {
                            vm.deleteSelected()
                        } label: {
                            ButtonLabel(symbolName: "trash", label: "Delete")
                        }
                    }
                    
                }
            }
        }
    }
    
}
