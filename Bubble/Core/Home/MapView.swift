//
//  MapView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.09.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var vmMap = ContentMapViewMolde()
   
                    
    var body: some View {
        Map(coordinateRegion: $vmMap.region,showsUserLocation: true)
                    .edgesIgnoringSafeArea(.all)
                    .accentColor(Color.red)
                    .onAppear {vmMap.CheckIfLocationSaervesEnbled()}
    }
        
}

#Preview {
    MapView()
}

