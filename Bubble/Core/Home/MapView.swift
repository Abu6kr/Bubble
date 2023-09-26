//
//  MapView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.09.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 40.83834587046632,
                        longitude: 14.254053016537693),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.03,
                        longitudeDelta: 0.03)
                    )
    var body: some View {
        Map(coordinateRegion: $region)
                    .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MapView()
}
