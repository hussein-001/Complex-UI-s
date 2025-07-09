//
//  imageLoaderView.swift
//  Spotify
//
//  Created by Hussien Awada on 27/06/2025.
//

import SwiftUI

struct imageLoaderView: View {
    
    var url: String = Constants.randomImage
    
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .opacity(0.0001)
            .overlay {
                AsyncImage(url: URL(string: url)) { image in
                    if let image = image.image {
                        image
                            .resizable() // Make the image resizable
                            .aspectRatio(contentMode: .fill) // Fill the frame
                    } else if image.error != nil {
                        Color.red // Indicate error
                    } else {
                        ProgressView() // Show loading indicator
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .cornerRadius(8)
                .allowsTightening(false)// never click the image, users click the rectangle
            }
            .clipped()
    }
}

#Preview {
    imageLoaderView()
        .cornerRadius(30)
        .padding()
    
}
