//
//  TabBarCutemsView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 01.10.2023.
//

import SwiftUI

struct TabBarCutemsView: View {
    @State private var sectionBar: Tab = .map
    var body: some View {
        ZStack {
            switch sectionBar {
            case .map:
                ZStack {
                    Color.red.ignoresSafeArea(.all)
                    Text("map")
                }
            case .profil:
                ZStack {
                    Color.green.ignoresSafeArea(.all)
                     Text("profil")
                }
               
            case .message:
                ZStack {
                    Color.blue.ignoresSafeArea(.all)
                    Text("message")

                }
            }
            
            
            HStack {
                
                ForEach(modeTabBar){ items in
                    Button(action: {
                        sectionBar = items.tab
                    }, label: {
                        Image(systemName: items.icone)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(sectionBar == items.tab ? Color.red : Color.them.ColorblackSwich)
                     
                    })

                }
                .frame(maxWidth: .infinity)
                
            }
                .frame(maxWidth: .infinity)
                .frame(height: 66)
                .background(Color.them.ColorBox)
                .clipShape(.rect(cornerRadius: 20))
                .padding(.horizontal,40)
                .frame(maxHeight: .infinity,alignment: .bottom)
        }
    }
}

#Preview {
    TabBarCutemsView()
}

struct ModeTabBar: Identifiable {
    let id = UUID().uuidString
    let icone: String
    let tab: Tab
}

enum Tab {
    case map
    case profil
    case message
}
let modeTabBar: [ModeTabBar] = [
    ModeTabBar(icone: "message.badge.filled.fill", tab: .message),
    ModeTabBar(icone: "map.fill", tab: .map),
    ModeTabBar(icone: "person.fill", tab: .profil),


]
