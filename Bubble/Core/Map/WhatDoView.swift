//
//  WhatDoView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 09.10.2023.
//

import SwiftUI

struct WhatDoView: View {
    @State private var whatDo: Bool = false

    var body: some View {
        ZStack {
            Image(systemName: "music.note")
                  .font(.system(size: 18).weight(.semibold))
                  .foregroundStyle(Color.them.ColorblackSwich)
                  .offset(y: whatDo ? -30 : 0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever()){
                whatDo = true
            }
        }
    }
}

#Preview {
    WhatDoView()
    
}
