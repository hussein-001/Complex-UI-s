//
//  TitleCategoryCell.swift
//  Spotify
//
//  Created by Hussien Awada on 28/06/2025.
//

import SwiftUI

struct CategoryCell: View {
    
    var title: String
    var isSelected: Bool
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical,8)
            .padding(.horizontal,10)
            .themeColors(isSelected: isSelected)
            .clipShape(Capsule())
    }
}

extension View {
    
    func themeColors(isSelected: Bool) -> some View {
        self
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            
    }
}

#Preview {
    CategoryCell(title: "Title", isSelected: false)
}
