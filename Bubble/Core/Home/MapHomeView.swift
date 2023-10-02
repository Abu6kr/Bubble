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

