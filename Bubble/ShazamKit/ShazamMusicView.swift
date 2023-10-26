//
//  ShazamMusicView.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 19.10.2023.
//

import SwiftUI

struct ShazamMusicView: View {
    
    @StateObject private var vmShazam = ShazamKitViewModel()
    @Binding var ShazamShow: Bool
    
    var body: some View {
        ZStack {
            Color.them.Colorblack.ignoresSafeArea()
            VStack {
                AsyncImage(url: vmShazam.shazamMedia.albumArtURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    EmptyView()
                }
                
                VStack(alignment: .center) {
                    Spacer()
                    AsyncImage(url: vmShazam.shazamMedia.albumArtURL) { image in
                        image
                            .resizable()
                            .frame(width: 300, height: 300)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.purple.opacity(0.5))
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                            .redacted(reason: .privacy)
                    }
                    VStack(alignment: .center) {
                        Text(vmShazam.shazamMedia.title ?? "Title")
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        Text(vmShazam.shazamMedia.artistName ?? "Artist Name")
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                    }.padding()
                    Spacer()
                    Button(action: {vmShazam.startOrEndListening()}) {
                        Text(vmShazam.isRecording ? "Listening..." : "Start Shazaming")
                            .frame(width: 300)
                    }.buttonStyle(.bordered)
                        .controlSize(.large)
                        .clipShape(.rect(cornerRadius: 22))
                        .shadow(radius: 4)
                }
            }
        }
    }
}

#Preview {
    ShazamMusicView(ShazamShow: .constant(false))
}
