//
//  MapHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 03.10.2023.
//

import SwiftUI
import MapKit

struct MapHomeView: View {
    @StateObject var vmProfile =  ProfilesViewMolde()
    @State private var camerPosition: MapCameraPosition = .region(.userRegion)
    
    @State private var searchText = ""
    
    @State private var resuts = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var shoeDitels: Bool = false
    @State private var getDitretion: Bool = false
    
    @State private var retrDisPlating = false
    @State private var reute: MKRoute?
    @State private var rounDestion: MKMapItem?
    
    @State private var showSearch: Bool = false
    
    @State private var mapStyleSelection: MapStylesSelection = .standard
    
    @State private var ShazamShow: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $camerPosition, selection: $mapSelection){
                    
                    Annotation("Abo", coordinate: .userLocation){
                        ZStack {
                            Button {
                                
                            } label: {
                                ZStack(alignment: .top) {
                                    WhatDoView()
                                    Image("Avatar")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .padding(10)
                                        .background(Color.orange)
                                        .clipShape(Circle())
                               
                                }
                            }
                        }
                    }
                    Annotation("Chara", coordinate: .userLocation2){
                        ZStack {
                            Button {
                                
                            } label: {
                                Image("Avatar2")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .padding(10)
                                    .background(Color.green)
                                    .clipShape(Circle())
                            }
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
                    
                    if let reute {MapPolyline(reute.polyline).stroke(.blue, lineWidth: 6)}
                }
                .mapStyle(getMapStyle())
                
                VStack(alignment: .leading, spacing: 22){
                    Button(action: {
                        withAnimation(.smooth){self.toggleMapStyle()}
                    }) {
                        switch mapStyleSelection {
                        case .standard:
                            Image(systemName: "map.fill")
                                .frame(width: 40, height: 40)
                                .background(Color.them.ColorBox)
                                .clipShape(.rect(cornerRadius: 12))
                        case .hybrid:
                            Image(systemName: "mappin.and.ellipse")
                                .frame(width: 40, height: 40)
                                .background(Color.them.ColorBox)
                                .clipShape(.rect(cornerRadius: 12))
                        case .imagery:
                            Image(systemName: "mappin.slash.circle")
                                .frame(width: 40, height: 40)
                                .background(Color.them.ColorBox)
                                .clipShape(.rect(cornerRadius: 12))
                        }
                    }.frame(maxWidth: .infinity ,alignment:.leading)
                    
                    Button {
                        ShazamShow.toggle()
                    } label: {
                        Image(systemName: "shazam.logo")
                            .frame(width: 40, height: 40)
                            .background(Color.them.ColorBox)
                            .clipShape(.rect(cornerRadius: 12))
                    }

                }.padding(.leading)
                    .sheet(isPresented: $ShazamShow){
                        ShazamMusicView(ShazamShow: $ShazamShow)
                            .presentationDetents([.height(550)])
                    }

                CustemsHeaderBar(searchBar: $showSearch, colorbackground: Color.clear , title: "")
                    .frame(maxHeight: .infinity,alignment: .top)
                    .sheet(isPresented: $showSearch) {
                        HomeSearchView(search: $searchText)
                            .presentationDetents([.height(350),.large])
                            .presentationBackground(.thinMaterial)
                            .presentationBackgroundInteraction(.enabled(upThrough: .height(450)))
                            .presentationCornerRadius(12)
                    }
            }
            .onChange(of: getDitretion, { oldValue, newValue in
                if newValue {fatchRoute()}})
            
            .onAppear {
                vmProfile.loadImage(forKey: "imagePrilesKeySaved")
                withAnimation(.easeInOut){DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                        if searchText.isEmpty {showSearch = false}}}
            }
            .onSubmit(of: .text) {Task { await searchPlace()}}
            .onChange(of: mapSelection, { oldValue, newValue in
                shoeDitels = newValue !=  nil})
            .sheet(isPresented: $shoeDitels) {
                LocationDitelsView(mapSection: $mapSelection, show: $shoeDitels, getDitretion: $getDitretion)
                    .presentationDetents([.height(450)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(450)))
                    .presentationCornerRadius(12)
            }
            .mapControls {
                MapCompass()
                //MARK: 3D
                MapPitchToggle()
                //MARK: userLocation
                MapUserLocationButton()
                
                MapScaleView()
            }
        }
    }
    private func getMapStyle() -> MapStyle {
            switch mapStyleSelection {
                case .standard:
                    return .standard
                case .hybrid:
                    return .hybrid
                case .imagery:
                    return .imagery
            }
        }
    private func toggleMapStyle() {
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
    
    private var searchButtonSection: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    withAnimation(.easeInOut){
                        showSearch.toggle()
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 40, height: 40)
                        .background(Color.them.ColorBox)
                        .clipShape(.rect(cornerRadius: 12))
                }
            }.padding(.horizontal)
                .padding(.bottom,80)
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



enum MapStylesSelection {
    case standard
    case hybrid
    case imagery
}
