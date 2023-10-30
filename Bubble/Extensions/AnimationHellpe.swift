//
//  AnimationHellpe.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 30.10.2023.
//

import SwiftUI

struct AnimationHellpe: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AnimationHellpe()
}


struct MoicAnimation: View {
    @State var micRecoreind = true
    var body: some View {
        VStack {
            ZStack {
                
                Circle()
                    .frame(width: micRecoreind ? 0 : 30, height: 30)
                    .foregroundStyle(Color.blue.opacity(0.3))
                Circle()
                    .frame(width: micRecoreind ? 0 : 22, height: 22)
                    .foregroundStyle(Color.blue.opacity(0.6))
                Circle()
                    .frame(width: micRecoreind ? 0 : 15, height: 15)
                    .foregroundStyle(Color.blue.opacity(0.5))
                
                Image(systemName: "mic.fill")
                    .font(.system(size: 12,weight: .regular))
                    .foregroundStyle(Color.black)
                   
            }
                
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.00).repeatForever()) {
                micRecoreind.toggle()
            }
        }
    }
}

#Preview {
    MoicAnimation()
}
