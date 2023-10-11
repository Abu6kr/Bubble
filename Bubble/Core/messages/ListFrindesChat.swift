//
//  ListFrindesChat.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 11.10.2023.
//

import SwiftUI

struct ListFrindesChat: View {
    var body: some View {
        List {
            ForEach(0..<5){ items in
                NavigationLink {
                    
                } label: {
                    HStack {
                        Circle()
                            .frame(width: 50,height: 50)
                        VStack(alignment: .leading) {
                            Text("NameUser")
                                .font(.system(size: 15,weight: .semibold))
                            
                            Text("name")
                                .font(.system(size: 15,weight: .regular))
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
            }
            .onDelete(perform: { indexSet in
                
            })
        }.listStyle(.plain)
        
    }
}

#Preview {
    ListFrindesChat()
}
