//
//  ProfileDitelsView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 19.10.2023.
//

import SwiftUI

struct ProfileDitelsView: View {
    
    @State private var showYourLocation: Bool = true
    @State private var showSearch: Bool = false
    @StateObject var vmProfie = ProfilesViewMolde()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            
            ScrollView {
                HStack {
                    HStack(spacing: 15) {
                        Button(action: {dismiss()}, label: {
                            Image(systemName: "chevron.left")
                                .frame(width: 44,height: 44)
                              .background(Color.them.ColorBox)
                             .clipShape(Circle())
                             .foregroundStyle(Color.them.ColorblackSwich)

                        })
//                            if let image = vmProfie.imageProfiles {
//                             Image(uiImage: image)
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 44,height: 44)
//                                    .background(Color.them.ColorBox)
//                                    .clipShape(Circle())
//                            }
                        Spacer()
                    }
                }.padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .clipShape(.rect(cornerRadius: 20))
                VStack(alignment: .leading) {
                    
                    Text("Frineds")
                        .font(.system(size: 18,weight: .semibold))
                        .padding(.horizontal)
                    ZStack(alignment: .top) {
                        
                        HStack {
                            ForEach(0 ..< 5) { item in
                                Image("")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60,height: 60)
                                    .background(Color.red)
                                    .clipShape(Circle())
                            }
                        }
                        
                        HStack {
                            Text("List Frindes")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }.padding(.vertical)
                            .padding(.top,50)
                            .offset(y: 10)
                        
                    }.padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.them.ColorBox)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.horizontal)
                    
                    
                    Toggle(isOn: $showYourLocation) {
                        Text("Show Location")
                    }.padding()
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileDitelsView()
}
