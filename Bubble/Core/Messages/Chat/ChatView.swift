//
//  ChatView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 12.10.2023.
//

import SwiftUI


struct ChatView: View {
    let colums:[GridItem] = [GridItem(.flexible()),GridItem(.flexible()),]

    var body: some View {
        ZStack {
            CustomNavBarContainerView {
                ScrollView {
                  
                }
                .customNavigationTitle("New Title")
                .customNavigationSubtitle("subtitle")
                .customNavigationBarBackButtonHidden(false)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChatView()
}


