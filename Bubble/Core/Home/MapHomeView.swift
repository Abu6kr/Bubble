//
//  MapHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.09.2023.
//

import SwiftUI
import MapKit

struct MapHomeView: View {
    @State private var showFrindesLocation: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                MapView()
                if !showFrindesLocation {
                    FluidGradient(blobs: [Color.blue,Color.black,Color.white,Color.black]).ignoresSafeArea(.all)
                        .opacity(0.5).background(VisualEffect(style: .systemThickMaterial)).ignoresSafeArea(.all).opacity(0.5)
                }
                VStack {
                    HeaderUser()
                    Spacer()
                    Button(action: {withAnimation(.smooth){showFrindesLocation.toggle()}}){
                        ButtonCutemsLogin(title: "Show Loction", background: Color.them.ColorBox, foregroundStyle: Color.them.ColorblackSwich)
                    }
                  
                    
                }
            }
        }
    }
}


struct MapHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MapHomeView()
    }
}

