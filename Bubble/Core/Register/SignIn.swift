//
//  SignIn.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 27.09.2023.
//

import SwiftUI

struct SignIn: View {
    @State private var Email: String = ""
    var body: some View {
        ZStack {
            FluidGradient(blobs: [Color.blue,Color.black,Color.white]).ignoresSafeArea(.all)
                .opacity(0.5).background(VisualEffect(style: .systemThickMaterial)).ignoresSafeArea(.all).opacity(0.5)
            VStack {
                
                VStack(alignment: .center,spacing: 10){
                    Text("Wellcome!")
                        .font(.system(size: 15,weight: .regular))
                    Text("Sign in")
                        .font(.system(size: 25,weight: .bold))
                    Text("Please fill your informations")
                        .font(.system(size: 15,weight: .regular))
                        .foregroundStyle(Color.gray)
                }
                VStack(alignment: .leading) {
                    Text("Email")
                    HStack {
                        TextField("Email", text: $Email)
                        Image(systemName: "envelope")
                    }
                }.padding()
                    .frame(maxWidth: .infinity,maxHeight: 100)
                    .background(Color.them.ColorBox)
                    .cornerRadius(22, corners: [.topLeft, .topRight])
                    .cornerRadius(8, corners: [.bottomRight, .bottomLeft])
                    .padding(.horizontal)
                
               
            }
        }
    }
}

#Preview {
    SignIn()
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
