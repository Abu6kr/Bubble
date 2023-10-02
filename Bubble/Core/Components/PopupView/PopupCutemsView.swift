//
//  PopupCutemsView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 30.09.2023.
//

import SwiftUI

struct PopupCutemsView: View {
    
    @State private var animationImaes = false
    @State private var animationText = false
    @State private var animationButton = false

    let colorFluidGradient: Color
    @Binding var dismiss: Bool
    
    let title: String
    let discrip: String
    
    @State var swictPopView: PopupView = .Error

    var body: some View {
        ZStack {
            
            FluidGradient(blobs: [colorFluidGradient.opacity(0.2)])

            VStack {
                Button(action: {
                    withAnimation(.snappy){
                        dismiss.toggle()
                    }
                }){
                    Image(systemName: "xmark")
                        .font(.system(size: 10,weight: .semibold))
                        .foregroundStyle(Color.them.ColorblackSwich)
                        .padding(10)
                        .background(Color.them.ColorBox)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .padding(.all)
                }
              
                
                ZStack {
                    Circle()
                        .frame(width: 4,height: 4)
                        .frame(maxHeight:.infinity,alignment: .topTrailing)
                        .offset(x: animationImaes ? 10.0 : 0, y: animationImaes ? 10.0 : 0)
                    Circle()
                        .frame(width: 4,height: 4)
                        .frame(maxHeight:.infinity,alignment: .topTrailing)
                        .offset(x: animationImaes ? -30.0 : 0, y: animationImaes ? 40.0 : 0)
                    Circle()
                        .frame(width: 8,height: 8)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .offset(x: animationImaes ? -20.0 : 0, y: animationImaes ? -30.0 : 0)
                    Circle()
                        .frame(width: 11,height: 11)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .offset(x: animationImaes ? 20.0 : 0, y: animationImaes ? 10.0 : 0)
                    Circle()
                        .frame(width: 11,height: 11)
                        .frame(maxHeight:.infinity,alignment: .bottomLeading)
                        .offset(x: animationImaes ? -20.0 : 0, y: animationImaes ? -10.0 : 0)
                    Circle()
                        .frame(width: 12,height: 12)
                        .frame(maxHeight:.infinity,alignment: .bottomTrailing)
                        .offset(x: animationImaes ? 20.0 : 0, y: animationImaes ? -30.0 : 0)
                    
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .opacity(animationImaes ? 1 : 0)
                        .offset(y: animationImaes ? 0 : 10)
                }
                    .frame(width: 152, height: 152)
                    .foregroundStyle(colorFluidGradient)
                
                VStack(spacing: 24){
                    
                    Text(title)
                        .font(.system(size: 22,weight: .semibold))
                        .offset(y: animationText ? 0 : 10)
                        .opacity(animationText ? 1 : 0)
                    
                    Text(discrip)
                        .offset(y: animationText ? 0 : 30)
                        .opacity(animationText ? 1 : 0)
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.center)
                    
                }.padding(.top,24)
                Spacer()
                switch swictPopView {
                case .SuccessFully:
                    Button(action: {self.dismiss.toggle()}, label: {
                        Text("Done")
                            .font(.system(size: 18,weight: .bold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(colorFluidGradient)
                            .clipShape(.rect(cornerRadius: .infinity))
                            .padding(.all,24)
                    })
                case .VerifyEmail:
                    Text("Open email")
                        .font(.system(size: 18,weight: .bold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(colorFluidGradient)
                        .clipShape(.rect(cornerRadius: .infinity))
                        .padding(.all,24)
                case .Error:
                    Button(action: {self.dismiss.toggle()}, label: {
                        Text("Done")
                            .font(.system(size: 18,weight: .bold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(colorFluidGradient)
                            .clipShape(.rect(cornerRadius: .infinity))
                            .padding(.all,24)
                    })
                }
             
            }
           
            
        }.frame(maxWidth: .infinity)
            .frame(height: 520)
            .background(Color.them.Colorblack)
            .clipShape(.rect(cornerRadius: 45))
            .padding(.all)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.08)){
                    animationImaes.toggle()
                    animationText.toggle()
                }
            }
      
    }
}



struct PopupCutemsView_Previews: PreviewProvider {
    static var previews: some View {
        PopupCutemsView(colorFluidGradient: Color.them.ColorBlue, dismiss: .constant(false), title: "Successfully", discrip: "Yahoo! You have successfully verified the account.")
            .background(Color.them.ColorblackSwich)
            .previewLayout(.sizeThatFits)
        
    }
}



enum PopupView {
    case SuccessFully
    case VerifyEmail
    case Error
}
