//
//  ButtonDismiss.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 30.09.2023.
//

import SwiftUI

struct ButtonDismiss: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {dismiss()}){
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .font(.system(size: 18,weight: .semibold))
                    .foregroundStyle(Color.them.ColorblackSwich)
            }
        }.padding(.all)
    }
}



struct ButtonDismiss_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDismiss()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

struct ButtonBackward: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            Button(action: {dismiss()}, label: {
                Image(systemName: "chevron.backward.circle.fill")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .font(.system(size: 18,weight: .semibold))
                    .foregroundStyle(Color.them.ColorblackSwich)
            })
            Spacer()
        }.padding(.all)
    }
}

