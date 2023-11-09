//
//  AddMatingFrindesView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 09.11.2023.
//

import SwiftUI

struct AddMatingFrindesView: View {
    
    @State private var addFrindes: Bool = false
    @State private var date = Date()
    @Binding var dismis: Bool
    var body: some View {
        NavigationStack {
            ZStack {
                Color.them.Colorblack.ignoresSafeArea(.all)
                ScrollView {
                    VStack {
                        ForEach(0 ..< 5) { item in
                            HStack {
                                Image("")
                                    .resizable()
                                    .background(Color.red)
                                    .frame(width: 50,height: 50)
                                    .clipShape(Circle())
                                VStack(alignment: .leading,spacing: 5) {
                                    Text("name")
                                        .font(.system(size: 18,weight: .semibold))
                                    Text("UserName")
                                        .font(.system(size: 16,weight: .regular))
                                        .foregroundStyle(Color.gray)
                                }
                                Spacer()
                                Button {
                                    addFrindes.toggle()
                                } label: {
                                    Image(systemName: addFrindes ?"checkmark.circle" : "circle")
                                        .font(.system(size: 22,weight: .semibold))
                                        .foregroundStyle(addFrindes ? Color.green : Color.gray)
                                }
                            }.padding(.vertical,10)
                        }.padding(.horizontal)
                    }.padding(.top)
                }
                
                .navigationBarItems(trailing:
                    DatePicker("",selection: $date,displayedComponents: [.date])
                )
                .navigationBarItems(leading:
                Button(action: {dismis.toggle()}, label: {Image(systemName: "x.circle.fill")}))
            }.navigationTitle("Meeting")
        }
    }
}

#Preview {
    AddMatingFrindesView(dismis: .constant(false))
}
