//
//  MapHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.09.2023.
//

import SwiftUI
import MapKit

struct MapHomeView: View {
  
    var body: some View {
        NavigationStack {
            ZStack {
                MapView()
                FluidGradient(blobs: [Color.blue,Color.black,Color.white]).ignoresSafeArea(.all)
                    .opacity(0.5)
                    .background(VisualEffect(style: .systemThickMaterial)).ignoresSafeArea(.all)
                    .opacity(0.5)
                VStack {
                    HeaderUser()
                    Spacer()
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

