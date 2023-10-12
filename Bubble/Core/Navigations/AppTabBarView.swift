//
//  AppTabBarView.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 9/6/21.
//

import SwiftUI

// Generics
// ViewBuilder
// PreferenceKey
// MatchedGeometryEffect

struct AppTabBarView: View {
    @State private var showSngiView: Bool = false
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .map
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            MassageHomeView()
                .tabBarItem(tab: .messages, selection: $tabSelection)
            
            MapHomeView()
                .tabBarItem(tab: .map, selection: $tabSelection)
                .offset(y: 40)

            ProfilesHomeView(showSingView: $showSngiView)
                .tabBarItem(tab: .profile, selection: $tabSelection)
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            let autUser = try? AuthenticationManger.shered.getAuthenticationUser()
            self.showSngiView = autUser == nil ? true : false
        }
        .fullScreenCover(isPresented: $showSngiView) {
            SignIn(showSingInView: $showSngiView)
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        AppTabBarView()
    }
}

extension AppTabBarView {
    
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
