//
//  MassageHomeView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 11.10.2023.
//

import SwiftUI

struct MassageHomeView: View {
    
    @StateObject var vmProfie = ProfilesViewMolde()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ChatTopBar(vmProfie: vmProfie)
                    ListFrindesChat()
                }
            }
        }
    }
}

#Preview {
    MassageHomeView()
}
