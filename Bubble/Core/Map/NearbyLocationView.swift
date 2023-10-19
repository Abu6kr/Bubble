//
//  NearbyLocationView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 19.10.2023.
//

import SwiftUI
import MapKit

struct NearbyLocationView: View {
    
    @Binding var mapSection: MKMapItem?
    @Binding var show: Bool
    @State private var lookAroundScreen: MKLookAroundScene?
    @Binding var getDitretion: Bool
    
    var body: some View {
        VStack {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(mapSection?.placemark.name ?? "")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .padding(.leading)
//                    
//                    Text(mapSection?.placemark.title ?? "")
//                        .font(.footnote)
//                        .lineLimit(2)
//                        .foregroundStyle(.gray)
//                        .fontWeight(.semibold)
//                        .padding(.leading)
//                }.padding(.top)
//            }
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(0..<5) { scen in
                        if let scene = lookAroundScreen {
                            LookAroundPreview(initialScene: scene)
                                .frame(height: 64)
                                .background(Color.them.ColorBox)
                                .clipShape(.rect(cornerRadius: 12))
                                .padding()
                        } else {
                            Text("Looding")
                                .padding()
                                .frame(height: 64)
                                .background(Color.them.ColorBox)
                                .clipShape(.rect(cornerRadius: 12))
                            
                        }
                    }
                }.padding(.leading)
            }
            
            
        }
        .onAppear {
            fatchLookPrivet()
        }
        .onChange(of: mapSection) { oldValue, newValue in
            fatchLookPrivet()
        }
    }
}
extension NearbyLocationView {
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
    NearbyLocationView(mapSection: .constant(nil), show: .constant(false), getDitretion: .constant(false))
}
