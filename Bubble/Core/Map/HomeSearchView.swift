//
//  HomeSearchView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 19.10.2023.
//

import SwiftUI
import MapKit

struct HomeSearchView: View {
    
//    @Binding var mapSection: MKMapItem?
//    @Binding var show: Bool
//    @State private var lookAroundScreen: MKLookAroundScene?
//    @Binding var getDitretion: Bool
    
    @Binding var search: String
    @State private var mapSelection: MKMapItem?
    @FocusState private var focusedField: FocusField?
    enum FocusField: Hashable {
        case search
    }
    let suggestions = ["Food", "play", "shopping","coofee","games"]

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TextField("Search", text: $search)
                    if !search.isEmpty {
                        Button(action: {search = ""}, label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundStyle(Color.them.ColorblackSwich)
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .padding(10)
                .background(Color.them.ColorBox)
                .clipShape(.rect(cornerRadius: 10))
                .focused($focusedField, equals: .search)
                .padding(.horizontal)
            }.padding(.top)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(suggestions,id: \.self) { text in
                        Button(action: {
                            search = text
                        }, label: {
                            Text(text)
                                .padding()
                                .background(Color.them.ColorBox)
                                .clipShape(.rect(cornerRadius: 10))
                        })
                    }
                }.padding()
            }
            VStack(alignment: .leading) {
                Text("Story")
                    .font(.system(size: 17,weight: .semibold))
                    .padding(.horizontal)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0 ..< 5) { item in
                            ZStack(alignment: .top) {
                                Rectangle()
                                    .frame(maxWidth:.infinity)
                                    .frame(height: 160)
                                    .foregroundStyle(Color.black)
                                    .offset(y: -10)
                                VStack(alignment: .leading) {
                                    Text("What to watch")
                                        .font(.system(size: 10,weight: .regular))
                                        .foregroundStyle(Color.gray)
                                    Text("Stream the Acme event")
                                        .font(.system(size: 10,weight: .regular))
                                        .foregroundStyle(Color.white)
                                }.padding(.top)
                            }.frame(width: 130,height: 170)
                                .background(Color.white)
                                .clipShape(.rect(cornerRadius: 14))
                                .padding(6)
                                .shadow(color: .black.opacity(0.25), radius: 5.5)
                        }
                    }
                }
            }.padding(.vertical)
            
//            NearbyLocationView(mapSection: $mapSection, show: $show, getDitretion: $getDitretion)
//                .clipShape(.rect(cornerRadius: 10))
//                .padding()
        }
        .onAppear {
            self.focusedField = .search
        }
    }
}

#Preview {
    HomeSearchView(search: .constant(""))
}

