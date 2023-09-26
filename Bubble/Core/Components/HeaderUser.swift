//
//  HeaderUser.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 26.09.2023.
//

import SwiftUI

struct HeaderUser: View {
    
    let title: String = "Hello ,"
    var userName: String = "Samms"
    
    var body: some View {
        HStack {
           Image("")
                .resizable()
                .frame(width: 40, height: 40)
                .background(Color.orange)
                .clipShape(Capsule())
            
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.regular)
                Text(userName)
                    .fontWeight(.semibold)
            }
            .padding(.leading)
            Spacer()
            
            NavigationLink {
                Text("Nativcation View")
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: "bell")
                        .symbolRenderingMode(.multicolor)
                    Text("3")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 24,height: 24)
                        .background(Color.blue)
                        .clipShape(.circle)
                }
                .frame(width: 94, height: 48)
                .background(VisualEffect(style: .systemThickMaterial))
                .clipShape(.capsule)
            }
         
            
        }.padding(.horizontal,16)
        .frame(maxWidth: .infinity)
        .frame(height: 96)
        .background(VisualEffect(style: .systemThickMaterial))
        .clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal)

    }
}

struct HeaderUser_Previews: PreviewProvider {
    static var previews: some View {
        HeaderUser()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

struct VisualEffect: UIViewRepresentable {
    @State var style : UIBlurEffect.Style 
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
