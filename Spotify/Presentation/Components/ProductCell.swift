//
//  ProductCell.swift
//  Spotify
//
//  Created by Hussien Awada on 29/06/2025.
//

import SwiftUI

struct ProductCell: View {
    
    var imageName: String = Constants.randomImage
    var title: String = "hello worlddfdfddfgdfgfsdwd"
    
    var body: some View {
        HStack(spacing: 16) {
            imageLoaderView(url: imageName)
                .frame(width: 55, height: 55)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColors(isSelected: false)
        .clipShape(.capsule)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        VStack {
            HStack {
                ProductCell()
                ProductCell()
            }
            HStack {
                ProductCell()
                ProductCell()
            }
        }
    }
}
