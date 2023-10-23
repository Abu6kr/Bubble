//
//  OnboardingView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 23.10.2023.
//

import SwiftUI

struct OnboardingView: View {
    @State private var sectionIndx = 0
    var body: some View {
        ZStack {
            FluidGradientViewColor()
            VStack {
                TabView(selection: $sectionIndx) {
                    Onboarding(image: "Avatar", title: "Map Find", subtitle: "Transforming lives by offering hope and opportunities for recovery, wellness, and independence.", Lottie: "Lottie1")
                        .tag(0)
                    Onboarding(image: "Avatar2", title: "Findes Shere Location", subtitle: "Transforming lives by offering hope and opportunities for recovery, wellness, and independence.", Lottie: "Lottie2")
                        .tag(1)
                    Onboarding(image: "Avatar4", title: "Behavioral Health Service", subtitle: "Transforming lives by offering hope and opportunities for recovery, wellness, and independence.", Lottie: "")
                        .tag(2)
                }.tabViewStyle(.page(indexDisplayMode: .always))
                HStack(alignment: .center) {
                    Spacer()
                
                    if sectionIndx == 2 {
                        withAnimation(.bouncy) {
                            Button(action: {
                                //MARK: move to loging view
                            }){
                                ButtonCutemsLogin(title: "Start", background: Color.white, foregroundStyle: Color.black)
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        withAnimation(.bouncy) {
                            if sectionIndx == 0 {
                                sectionIndx += 1
                            } else if sectionIndx == 1 {
                                sectionIndx += 1
                            } else if sectionIndx == 2 {
                                sectionIndx = 2
                            }
                        }
                    }) {
                        
                        Image(systemName: "chevron.forward.circle.fill")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .foregroundStyle(Color.them.ColorblackSwich)
                    }
                     
                }.padding()
            }
        }
    }
}

#Preview {
    OnboardingView()
}

struct Onboarding: View {
    
    let image: String
    let title: String
    let subtitle: String
    let Lottie: String
    
    @State var textAnmshin: Bool = false
    @State var  imagsAnmshin: Bool = false
    
    var body: some View {
        VStack {
            if Lottie.isEmpty {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 180)
                    .opacity(imagsAnmshin ? 1 : 0)
                    .padding(.top)
            } else {
                LottieView(lottieFile: Lottie, loopMode: .loop)
                    .frame(width: 180, height: 180)
                    .offset(y: textAnmshin ? 0 : -30)
                    .opacity(imagsAnmshin ? 1 : 0)
            }
      
            
            VStack(alignment: .center,spacing: 20) {
                Text(title)
                    .font(.system(size: 20,weight: .bold))
                    .multilineTextAlignment(.center)
                    .frame(width: 230)
                    .offset(y: textAnmshin ? 0 : 30)
                    .opacity(textAnmshin ? 1 : 0)
                
                Text(subtitle)
                    .font(.system(size: 15,weight: .light))
                    .multilineTextAlignment(.center)
                    .offset(y: textAnmshin ? 0 : 50)
                    .opacity(textAnmshin ? 1 : 0)
            }.padding(.init(top: 50, leading: 10, bottom: 40, trailing: 10))

        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2)) {
                textAnmshin = true
                imagsAnmshin = true
            }
        }
    }
}
