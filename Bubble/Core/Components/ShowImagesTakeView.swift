//
//  ShowImagesTakeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 02.11.2023.
//

import SwiftUI

struct ShowImagesTakeView: View {
    let imageTake: [Image] = []
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.system(size: 22,weight: .semibold))
                    .foregroundStyle(Color.white)
                    .offset(y: 18)
                
                Image("Story2")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(5)
                    .background(Color.white)
                    .clipShape(.rect(cornerRadius: 15))
            }

        }
    }
}

#Preview {
    ShowImagesTakeView()
}
