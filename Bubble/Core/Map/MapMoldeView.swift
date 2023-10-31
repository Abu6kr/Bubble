//
//  MapMoldeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.10.2023.
//

import SwiftUI
import Foundation
import MapKit

class MapMoldeView : ObservableObject {
    
    @Published var mapStyleSelection: MapStylesSelection = .standard
    @Published var searchText = ""
    @Published var showYourLocation: Bool = true
    
    func potentialAsyncFunction(_ newState: Bool) {
            self.showYourLocation = newState
        }

    
     func getMapStyle() -> MapStyle {
            switch mapStyleSelection {
                case .standard:
                    return .standard
                case .hybrid:
                    return .hybrid
                case .imagery:
                    return .imagery
            }
        }
    
     func toggleMapStyle() {
          switch mapStyleSelection {
              case .standard:
                  mapStyleSelection = .hybrid
              case .hybrid:
                  mapStyleSelection = .imagery
              case .imagery:
                  mapStyleSelection = .standard
          }
      }
    
}



enum MapStylesSelection {
    case standard
    case hybrid
    case imagery
}

//MARK: map extension Locatione
extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
//        return .init(latitude: 25.7682, longitude: -80.1959)
        return .init(latitude: 56.840506, longitude:  60.659330)
    }
}


extension CLLocationCoordinate2D {
    static var userLocation2: CLLocationCoordinate2D {
        return .init(latitude: 25.8682, longitude: -80.1959)

    }
}
extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
                     latitudinalMeters: 1000,
                     longitudinalMeters: 1000)
    }
}
