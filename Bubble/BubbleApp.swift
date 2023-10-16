//
//  BubbleApp.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.09.2023.
//

import SwiftUI
import Firebase

@main
struct BubbleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var showLaunchView: Bool = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                AppTabBarView()
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))

                    }
                }
                .zIndex(2.0)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? =
                     nil) -> Bool {
        FirebaseApp.configure()
//        print("Configure Firebase")
        return true
    }
}

