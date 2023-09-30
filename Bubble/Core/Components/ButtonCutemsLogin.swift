//
//  ButtonCutemsLogin.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 28.09.2023.
//

import SwiftUI

struct ButtonCutemsLogin: View {
    let title: String
    let background: Color
    let foregroundStyle: Color
//    let sizeFont: CGFloat
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 18,weight: .semibold))
                .frame(width: 200, height: 56)
                .background(background)
                .foregroundStyle(foregroundStyle)
                .clipShape(.rect(cornerRadius: 30))
        }
    }
}



struct ButtonCutemsLogin_Previews: PreviewProvider {
    static var previews: some View {
        ButtonCutemsLogin(title: "Sign in now", background: Color.them.ColorBlue, foregroundStyle: Color.white)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
