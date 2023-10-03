//
//  MapHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 03.10.2023.
//

import SwiftUI
import MapKit

struct MapHomeView: View {
    @StateObject private var vmMap = ContentMapViewMolde()
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
        .overlay(alignment:.top) {
            TextField("Search for a lcoation", text: $searchText)
                .padding()
                .background(Color.them.ColorBox)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .onChange(of: getDitretion, { oldValue, newValue in
            if newValue {
                fatchRoute()
            }
        })
        .onAppear {vmMap.CheckIfLocationSaervesEnbled()}
        .onSubmit(of: .text) {
            Task { await searchPlace() }
        }
        .onChange(of: mapSelection, { oldValue, newValue in
            shoeDitels = newValue !=  nil
        })
        .sheet(isPresented: $shoeDitels) {
            LocartionDitelsView(mapSection: $mapSelection, show: $shoeDitels, getDitretion: $getDitretion)
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




struct LocartionDitelsView: View {
    
    @Binding var mapSection: MKMapItem?
    @Binding var show: Bool
    @State private var lookAroundScreen: MKLookAroundScene?
    @Binding var getDitretion: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(mapSection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    
                    Text(mapSection?.placemark.title ?? "")
                        .font(.footnote)
                        .lineLimit(2)
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                        .padding(.leading)
                }.padding(.top)
                Spacer()
                Button {
                    show.toggle()
                    mapSection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            if let scene = lookAroundScreen {
              LookAroundPreview(initialScene: scene)
                    .frame(height: 250)
                    .clipShape(.rect(cornerRadius: 12))
                    .padding()
            } else {
                ContentUnavailableView("No private avilepoels", systemImage: "nosign")
            }
            
            HStack {
                Button {
                    if let mapSection {
                        mapSection.openInMaps()
                    }
                } label: {
                    Text("Opne in Map")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(width: 170, height: 48)
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 12))
                }
                
                Button {
                   getDitretion = true
                    show = false
                } label: {
                    Text("Get Diretion")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(width: 170, height: 48)
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 12))
                }
            }.padding()
            
        }
        .onAppear {
            fatchLookPrivet()
        }
        .onChange(of: mapSection) { oldValue, newValue in
            fatchLookPrivet()
        }
        .padding()
    }
}
extension LocartionDitelsView {
    func fatchLookPrivet() {
        if let mapSection {
            lookAroundScreen = nil
            Task {
                let requset = MKLookAroundSceneRequest(mapItem: mapSection)
                lookAroundScreen = try? await requset.scene
            }
        }
    }
}

#Preview {
    LocartionDitelsView(mapSection: .constant(nil), show: .constant(false), getDitretion: .constant(false))
}
