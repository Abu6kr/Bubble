//
//  AvatersView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 09.10.2023.
//

import SwiftUI

struct AvatersView: View {
    @ObservedObject var vmProfie = ProfilesViewMolde()
    @Environment(\.dismiss) var  dismiss
    var body: some View {
        ZStack {
            FluidGradientViewColor()
            ScrollView {
                VStack {
                    ButtonDismiss(dismiss: _dismiss)
                    LazyVGrid(columns: vmProfie.colums){
                        ForEach(vmProfie.avaer,id: \.self){ items in
                            Button(action: {
                                
                            }) {
                                Image(items)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60,height: 60)
                                    .padding(10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2.5)
                                            .foregroundStyle(Color.them.ColorblackSwich)
                                    )
                            }
                        }
                    }.padding(.top,30)
                }
            }
        }
    }
}

#Preview {
    AvatersView()
}
