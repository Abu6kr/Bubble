//
//  LaunchView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 03.10.2023.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your portfolio...".map { String($0) }

    @State private var animationLogo = false
    @State private var animationrotation = false
    @Binding var showLaunchView: Bool
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                Image("LogoApp")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 240,height: 128)
                    .offset(y: animationLogo ? 0 : 20)
                    .rotationEffect(Angle(degrees: animationrotation ? 0 : 200))
                    .offset(x: animationrotation ? 0 : 320)
            }
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()) {
                
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })

        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever()){
                animationLogo.toggle()
            }
            withAnimation(.easeInOut(duration: 1.5)) {
                animationrotation.toggle()
            }
            
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(false))
    }
}
