//
//  MassageHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 11.10.2023.
//

import SwiftUI

struct MassageHomeView: View {
    @Namespace var topID
    @StateObject var vmProfie = ProfilesViewMolde()
    @State private var showSearch = false
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [vmProfie.averageColor,Color.them.Colorblack,Color.them.Colorblack,Color.them.Colorblack,Color.them.Colorblack], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    CustemsHeaderBar(searchBar: $showSearch, colorbackground: Color.clear, title: "title")
                        .offset(y: -20)
                    ScrollView {
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack {
                                ForEach(0..<1) { frineds in
                                    VStack(alignment: .center) {
                                        Image("Avatar2")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 49,height: 49)
                                            .background(Color.pink.opacity(0.5))
                                            .clipShape(.circle)
                                            .frame(width: 55,height: 55)
                                            .background(
                                                RoundedRectangle(cornerRadius: .infinity)
                                                    .stroke(lineWidth: 2)
                                                    .foregroundStyle(Color.pink.opacity(0.5))
                                            )
                                        Text("Chara")
                                            .font(.system(size: 10,weight: .semibold))
                                    }
                                }
                            }.padding()
                        }
                        Divider()

                        ListFrindesChat()
                            .padding(.top)
                    }
                }
            }
            .onAppear {
                vmProfie.loadImage(forKey: "imagePrilesKeySaved")
            }
        }
    }
}

#Preview {
    MassageHomeView()
}
