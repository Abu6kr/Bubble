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
            StorySearchView()

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


