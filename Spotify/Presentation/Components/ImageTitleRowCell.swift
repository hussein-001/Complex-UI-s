//
//  ImageTitleRowCell.swift
//  Spotify
//
//  Created by Hussien Awada on 30/06/2025.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    var title: String = "Title"
    var imageName: String = Constants.randomImage
    var imageSize: CGFloat = 100
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8) {
            imageLoaderView(url: imageName)
                .frame(width: imageSize, height: imageSize)
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ImageTitleRowCell()
}
