//
//  ProfileDitelsView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 19.10.2023.
//

import SwiftUI
import MapKit

struct ProfileDitelsView: View {
    
    @State private var showYourLocation: Bool = true
    @State private var showSearch: Bool = false
    @StateObject var vmProfie = ProfilesViewMolde()
    @Environment(\.dismiss) var dismiss
    
    @State private var mapSelection: MKMapItem?
    @State private var camerPosition: MapCameraPosition = .region(.userRegion)
    var body: some View {
        ZStack {
            LinearGradient(colors: [vmProfie.averageColor,Color.them.Colorblack,Color.them.Colorblack,Color.them.Colorblack,Color.them.Colorblack], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
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
                            .foregroundStyle(Color.them.ColorblackSwich)
                        ZStack(alignment: .top) {
                            HStack {
                                ForEach(0 ..< 1) { item in
                                    Image("Avatar2")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60,height: 60)
                                        .background(Color.green)
                                        .clipShape(Circle())
                                }
                                Spacer()
                            }
                        }.padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.them.ColorBox)
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(.horizontal)
                        
                        
                        Toggle(isOn: $showYourLocation) {
                            Text("Show Location")
                                .font(.system(size: 18,weight: .semibold))
                                .foregroundStyle(Color.them.ColorblackSwich)
                        }.padding()
                        Map(position: $camerPosition, selection: $mapSelection){
                            if !showYourLocation == false {
                                Annotation("Abo", coordinate: .userLocation){
                                    ZStack {
                                        Image("Avatar")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .padding(10)
                                            .background(Color.orange)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                        }
                        .frame(height: 200)
                        .allowsHitTesting(false)
                    }
                }
            }
            .onAppear {
                vmProfie.loadImage(forKey: "imagePrilesKeySaved")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileDitelsView()
}
