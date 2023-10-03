//
//  LocationDitelsView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 03.10.2023.
//

import SwiftUI
import MapKit

struct LocationDitelsView: View {
    
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
extension LocationDitelsView {
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
    LocationDitelsView(mapSection: .constant(nil), show: .constant(false), getDitretion: .constant(false))
}
