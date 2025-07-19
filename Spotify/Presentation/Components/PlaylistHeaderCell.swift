//
//  PlaylistHeaderCell.swift
//  Spotify
//
//  Created by Hussien Awada on 09/07/2025.
//

import SwiftUI

struct PlaylistHeaderCell: View {
    
    var height: CGFloat = 250
    var title: String = "Some playlist title goes here"
    var subtitle: String = "Some subtitle goes here"
    var imagename: String = Constants.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.8)

    var body: some View {
        GeometryReader { geo in
            let minY = geo.frame(in: .global).minY

            ZStack(alignment: .bottomLeading) {
                imageLoaderView(url: imagename)
                    .frame(height: minY > 0 ? height + minY : height)
                    .clipped()
                    .offset(y: minY > 0 ? -minY : 0)

                // Gradient shadow overlay
                LinearGradient(
                    colors: [shadowColor.opacity(0.0), shadowColor],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: height)
                .clipped()

                // Title & Subtitle
                VStack(alignment: .leading, spacing: 6) {
                    Text(subtitle)
                        .font(.headline)
                        .foregroundStyle(.spotifyLightGray)

                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.spotifyWhite)
                }
                .padding(16)
                .offset(y: minY > 0 ? -minY : 0)
            }
        }
        .frame(height: height)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}
