//
//  MapHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 03.10.2023.
//

import SwiftUI
import MapKit

struct MapHomeView: View {
//    @StateObject private var vmMap = ContentMapViewMolde()
    @State private var camerPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText = ""
    @State private var resuts = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var shoeDitels: Bool = false
    @State private var getDitretion: Bool = false
    
    @State private var retrDisPlating = false
    @State private var reute: MKRoute?
    @State private var rounDestion: MKMapItem?
    
    var body: some View {
        ZStack {
            Map(position: $camerPosition, selection: $mapSelection){
                //            Marker("My Location",systemImage: "figure.stand",coordinate: .userLocation)
                //                .tint(.red)
                
                //            UserAnnotation()
                
                Annotation("My Location", coordinate: .userLocation){
                    ZStack {
                        Circle()
                            .frame(width: 32,height: 32)
                            .foregroundStyle(Color.blue.opacity(0.25))
                        Circle()
                            .frame(width: 20,height: 20)
                            .foregroundStyle(Color.white)
                        Circle()
                            .frame(width: 12,height: 12)
                            .foregroundStyle(Color.blue)
                    }
                }
                
                ForEach(resuts, id: \.self) { items in
                    if retrDisPlating {
                        if items == rounDestion {
                            let placemark = items.placemark
                            Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                        }
                    } else {
                        let placemark = items.placemark
                        Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                    }
                    
                }
                
                if let reute {
                    MapPolyline(reute.polyline)
                        .stroke(.blue, lineWidth: 6)
                }
            }
            VStack {
                
                HStack {
                    TextField("Search for a lcoation", text: $searchText)
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(Color.them.ColorblackSwich)
                    }

                }.padding(.horizontal)
                    .frame(maxWidth:.infinity)
                    .frame(height: 50)
                    .background(Color.them.ColorBox)
                    .clipShape(.rect(cornerRadius: 12))
                    .padding()
                
             
            }
        }
        .onChange(of: getDitretion, { oldValue, newValue in
            if newValue {
                fatchRoute()
            }
        })
//        .onAppear {vmMap.CheckIfLocationSaervesEnbled()}
        .onSubmit(of: .text) {
            Task { await searchPlace() }
        }
        .onChange(of: mapSelection, { oldValue, newValue in
            shoeDitels = newValue !=  nil
        })
        .sheet(isPresented: $shoeDitels) {
            LocationDitelsView(mapSection: $mapSelection, show: $shoeDitels, getDitretion: $getDitretion)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        }
        .mapControls {
            MapCompass()
            //MARK: 3D
            MapPitchToggle()
          //MARK: userLocation
            MapUserLocationButton()
        }
    }
}

extension MapHomeView {
    
    func searchPlace()  async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        
        let resuts = try? await MKLocalSearch(request: request).start()
        self.resuts = resuts?.mapItems ?? []
    }
    
    func fatchRoute() {
        if let mapSelection {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: .userLocation))
            request.destination = mapSelection
            
            Task {
                let reslt = try? await MKDirections(request: request).calculate()
                reute = reslt?.routes.first
                rounDestion = mapSelection
                
                withAnimation(.spring){
                    retrDisPlating = true
                    shoeDitels = false
                    
                    if let rect = reute?.polyline.boundingMapRect, retrDisPlating {
                        camerPosition = .rect(rect)
                    }
                }
            }
        }
    }
}
#Preview {
    MapHomeView()
}


extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 25.7682, longitude: -80.1959)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
                     latitudinalMeters: 1000,
                     longitudinalMeters: 1000)
    }
}
