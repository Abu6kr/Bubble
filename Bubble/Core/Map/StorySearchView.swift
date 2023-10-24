//
//  StorySearchView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 24.10.2023.
//

import SwiftUI

struct StorySearchView: View {
    @State private var shoeStory: Bool = false
    @State var selectedCity: MoldeStore?
    var body: some View {
        VStack(alignment: .leading) {
            Text("Story")
                .font(.system(size: 17,weight: .semibold))
                .padding(.horizontal)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(moldeStor) { item in
                        Button(action: {
                            selectedCity = item
                            shoeStory.toggle()
                        }){StoryList(molde: item)}
                        
                    .fullScreenCover(isPresented: $shoeStory, onDismiss: {selectedCity = nil}) {
                        StorySearch(molde: item)}
                    }
                }.padding(.leading)
            }
        }.padding(.vertical)
    }
}

#Preview {
    StorySearchView()
}

struct MoldeStore: Identifiable {
    var id = UUID().uuidString
    let title: String
    var property: Int
    let ditels: String
    let images: String
    init(id: String = UUID().uuidString, title: String, property: Int, ditels: String, images: String) {
        self.id = id
        self.title = title
        self.property = property
        self.ditels = ditels
        self.images = images
    }
}

let moldeStor : [MoldeStore] = [
    MoldeStore(title: "What to watch", property: 0, ditels: "Stream the Acme event", images: "Story1"),
    MoldeStore(title: "Plant a tree", property: 1, ditels: "Contribute to the planet", images: "Story2"),
    MoldeStore(title: "Supercharged", property: 2, ditels: "Creates beauty like a beast", images: "Story3")
]



struct StorySearch: View {
    @Environment(\.dismiss) var presentationMode
    var molde: MoldeStore?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            if let molde = molde {
                ZStack(alignment: .top) {
                    Image(molde.images)
                        .resizable()
                        .ignoresSafeArea()
                    Button(action: {presentationMode()}) {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.white)
                    }.frame(maxWidth: .infinity,alignment: .trailing)
                        .padding()
                    VStack(alignment: .leading,spacing: 10) {
                        Text(molde.title)
                            .font(.system(size: 30,weight: .regular))
                            .foregroundStyle(Color.gray)
                        Text(molde.ditels)
                            .font(.system(size: 22,weight: .regular))
                            .foregroundStyle(Color.white)
                    }.padding(.top)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding()
                }
            }
        }
    }
}
#Preview {
    StorySearch(molde:  MoldeStore(title: "Supercharged", property: 2, ditels: "Creates beauty like a beast", images: "Story3"))
}

struct StoryList: View {
    
    var molde: MoldeStore
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(molde.images)
                .resizable()
            VStack(alignment: .leading) {
                Text(molde.title)
                    .font(.system(size: 10,weight: .regular))
                    .foregroundStyle(Color.gray)
                Text(molde.ditels)
                    .font(.system(size: 10,weight: .regular))
                    .foregroundStyle(Color.white)
            }.padding(.top)
        }.frame(width: 130,height: 170)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 14))
            .shadow(color: .black.opacity(0.25), radius: 5.5)
        
    }
}
