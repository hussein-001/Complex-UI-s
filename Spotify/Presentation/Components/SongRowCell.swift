//
//  SongRowCell.swift
//  Spotify
//
//  Created by Hussien Awada on 19/07/2025.
//

import SwiftUI

struct SongRowCell: View {
    
    var imageSize: CGFloat = 50
    var imageName: String = Constants.randomImage
    var title: String = "Some Song name here"
    var subtitle: String? = "Some artist name here"
    var onCellPressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8) {
            imageLoaderView(url: imageName)
                .frame(width: imageSize, height: imageSize)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundStyle(Color.spotifyWhite)
                    .font(.body)
                    .fontWeight(.medium)
                if let subtitle {
                    Text(subtitle)
                        .foregroundStyle(Color.spotifyLightGray)
                        .font(.callout)
                }
            }
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
                onCellPressed?()
            }
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(Color.spotifyWhite)
                .padding(16)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    onEllipsisPressed?()
                }
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        SongRowCell()
    }
}
