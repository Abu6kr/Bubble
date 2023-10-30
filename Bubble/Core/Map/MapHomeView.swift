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
    
    @ObservedObject var vmMap = MapMoldeView()
    
    @State private var shoeDitelsForineds = false
    
    //MARK: cmaer modeView camers
    @State private var showCmaer: Bool = false
    @State private var ShazamShow: Bool = false
    @State private var showContact = false
    
    @StateObject var vmProfie = ProfilesViewMolde()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $camerPosition, selection: $mapSelection){
                    
                    Annotation("Abo", coordinate: .userLocation){
                        ZStack {
                            ZStack(alignment: .top) {
//                                WhatDoView()
                                if let image =  vmProfie.imageProfiles  {
                                    Image(uiImage: image)
                                        .resizable()
                                    .scaledToFill()
                                   .frame(width: 50, height: 50)
                                   .background(Color.them.ColorBox)
                                   .clipShape(Circle())
                                } else {
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
                                shoeDitelsForineds.toggle()
                            } label: {
                                Image("Avatar2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 55,height: 55)
                                    .background(Color.pink.opacity(0.5))
                                    .clipShape(.circle)
                            }
                        }.sheet(isPresented: $shoeDitelsForineds) {
                            FirendsDitelsView()
                                .presentationDetents([.height(400)])
                                .presentationBackground(.thinMaterial)
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
                .mapStyle(vmMap.getMapStyle())
                BarListTasksView(showCamera: $showCmaer, showShazam: $ShazamShow, showContact: $showContact, vmMap: vmMap)
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
        .onAppear {
            vmProfie.loadImage(forKey: "imagePrilesKeySaved")
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
        .environmentObject(ViewModel())
}



