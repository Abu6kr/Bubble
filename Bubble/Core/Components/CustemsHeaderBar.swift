//
//  CustemsHeaderBar.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 17.10.2023.
//

import SwiftUI

struct CustemsHeaderBar: View {
    
    @State var sectionBarondes: Bagroneds = .ThickMaterial
    @StateObject var vmProfie = ProfilesViewMolde()
    
    @Binding var searchBar: Bool
    let colorbackground: Color
    @State var title: String
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 15) {
                    if let image = vmProfie.imageProfiles {
                     Image(uiImage: image)
                            .resizable()
                            .frame(width: 44,height: 44)
                            .background(Color.them.ColorBox)
                            .clipShape(Circle())
                    }
                  
                    Button(action: {searchBar.toggle()}, label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.them.ColorblackSwich)
                            .font(.system(size: 15,weight: .semibold))
                            .frame(width: 44,height: 44)
                            .background(Color.them.ColorBox)
                            .clipShape(Circle())
                    })
                    Spacer()
                }
            }.padding()
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .background(colorbackground)
                .clipShape(.rect(cornerRadius: 20))
        }
        .onAppear {
            vmProfie.loadImage(forKey: "imagePrilesKeySaved")
        }

    }
}

struct CustemsHeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        CustemsHeaderBar(searchBar: .constant(false), colorbackground: Color.them.ColorOrange, title: "Map")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

enum Bagroneds {
    case colorSwict
    case ThickMaterial
}
