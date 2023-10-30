//
//  ChatView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 12.10.2023.
//

import SwiftUI


struct ChatView: View {
    let colums:[GridItem] = [GridItem(.flexible()),GridItem(.flexible()),]
    
    @State private var textChat: String = ""
    @State private var textChat2: String = ""
    @State private var sendMasage: Bool = false
    @State private var micRecoreind = false
    @State private var fullLogMessages: [String] = []
    
    var body: some View {
        ZStack {
            CustomNavBarContainerView {
                VStack {
                    ReverseScrollView {
                        ScrollView {
                            ForEach(fullLogMessages,id: \.self) { item in
                                Text(item)
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .padding(.horizontal)
                                    .background(Color.blue)
                                    .cornerRadius(22, corners: [.topLeft,.topRight,.bottomLeft])
                                    .frame(maxWidth:.infinity,alignment:.leading)
                                    .padding(.all)
                                
                            }
                        }
                    
                        
                    }.previewLayout(.sizeThatFits)
                    
                    HStack {
                        Button(action: {}, label: {
                            Image(systemName: "photo.stack")
                                .font(.system(size: 18,weight: .semibold))
                                .foregroundStyle(Color.them.ColorblackSwich)
                        })
                        HStack {
                            TextField("Chat", text: $textChat)
                            ZStack {
                               if micRecoreind == true {
                                    MoicAnimation(micRecoreind: micRecoreind)
                               } else {
                                   Circle()
                                       .frame(width: 30)
                                       .foregroundStyle(Color.blue)
                               }
                                Button(action: {micRecoreind.toggle()}, label: {
                                    Image(systemName: "mic.fill")
                                        .font(.system(size: 12,weight: .regular))
                                        .foregroundStyle(Color.white)
                                })
                            }
                        }
                        .padding(10)
                        .background(Color.them.Colorblack)
                        .clipShape(.rect(cornerRadius: 10))
                        
                        if textChat.isEmpty {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 22,weight: .bold))
                                .foregroundStyle(Color.gray)
                        } else {
                            Button(action: {
                                fullLogMessages.append(textChat)
                                textChat = ""
                            }, label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .font(.system(size: 22,weight: .bold))
                            })
                        }
                        
                    }
                    .padding(.all)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 15,weight: .regular))
                    .frame(height: 100)
                    .background(Color.them.ColorBox)
                    .cornerRadius(22, corners: [.topLeft,.topRight])
                    .frame(maxHeight: .infinity,alignment: .bottom)
                    .padding(.bottom,30)
                    .frame(height: 100)
                    
                }
                .customNavigationTitle("Chara")
                .customNavigationSubtitle("@cH782")
                .customNavigationBarBackButtonHidden(false)
            }
          
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChatView()
}




struct ReverseScrollView<Content>: View where Content: View {
    @State private var contentHeight: CGFloat = CGFloat.zero
    
    var content: () -> Content
    
    // Calculate content offset
    func offset(outerheight: CGFloat, innerheight: CGFloat) -> CGFloat {
        print("outerheight: \(outerheight) innerheight: \(innerheight)")
        
        return -(innerheight/2 - outerheight/2)
    }
    
    var body: some View {
        GeometryReader { outerGeometry in
            // Render the content
            //  ... and set its sizing inside the parent
            self.content()
            .modifier(ViewHeightKey())
            .onPreferenceChange(ViewHeightKey.self) { self.contentHeight = $0 }
            .frame(height: outerGeometry.size.height)
            .offset(y: self.offset(outerheight: outerGeometry.size.height, innerheight: self.contentHeight))
            .clipped()
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

extension ViewHeightKey: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(GeometryReader { proxy in
            Color.clear.preference(key: Self.self, value: proxy.size.height)
        })
    }
}


