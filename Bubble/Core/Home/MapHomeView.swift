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
    @FocusState private var keyboardFocused: Bool
    
    
    var body: some View {
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
                
                if let reute {
                    MapPolyline(reute.polyline)
                        .stroke(.blue, lineWidth: 6)
                }
            }
            searchButtonSection
                .overlay {searchBarSection}
        }
        .onChange(of: getDitretion, { oldValue, newValue in
            if newValue {
                fatchRoute()
            }
        })
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
            
//            MapScaleView()
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

extension MapHomeView {
    private var searchButtonSection: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation(.easeInOut){
                        showSearch.toggle()
                        keyboardFocused.toggle()
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
    private var searchBarSection: some View {
        HStack {
            TextField("Search for a lcoation", text: $searchText)
                .focused($keyboardFocused)
                .font(.system(size: 15))
                .fontWeight(.regular)
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
            .padding(.horizontal,60)
            .padding(.top,60)
            .opacity(showSearch ? 1 : 0)
            .frame(maxHeight: .infinity,alignment: .top)
    }

}
