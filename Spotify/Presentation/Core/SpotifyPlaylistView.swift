//
//  SpotifyPlaylistView.swift
//  Spotify
//
//  Created by Hussien Awada on 09/07/2025.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    
    var product: Product = Product.mock
    var user: User = .mock
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = false
    @State private var offset: CGFloat = 0
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    
                    // Invisible tracking view
                    Color.clear
                        .frame(height: 0)
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .onAppear {
                                        offset = geo.frame(in: .global).minY
                                    }
                                    .onChange(of: geo.frame(in: .global).minY) { newValue,oldValue in
                                        withAnimation {
                                            offset = newValue
                                            showHeader = newValue < -200
                                        }
                                    }
                            }
                        )
                    
                    // Stretchy header
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand ?? "",
                        imagename: product.thumbnail
                    )
                    .frame(height: 300)
                    
                    // Description section
                    PlayListDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category,
                        onAddToPlayListPresed: {},
                        onDownloadPressed: {},
                        onSharePressed: {},
                        onEllipsisPressed: {},
                        onShufflePressed: {},
                        onPlayPressed: {}
                    )
                    .padding(.horizontal, 16)
                    
                    // List of products
                    ForEach(products) { product in
                        NavigationLink(destination: SpotifyPlaylistView(product: product)) {
                            SongRowCell(
                                imageSize: 50,
                                imageName: product.thumbnail,
                                title: product.title,
                                subtitle: product.brand,
                                onCellPressed: {},
                                onEllipsisPressed: {}
                            )
                            .padding(.leading, 16)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            // Optional debug view
//            Text("Offset: \(Int(offset))")
//                .foregroundColor(.white)
//                .padding()
//                .background(Color.blue)
//                .frame(maxHeight: .infinity, alignment: .top)
//                .padding(.top, 60)
            
            // Floating sticky header
            ZStack {
                Text(product.title)
                    .font(.headline)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(.spotifyBlack)
                    .offset(y: showHeader ? 0 : -100)
                    .opacity(showHeader ? 1 : 0)
                
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding(10)
                    .background(
                        showHeader ? Color.spotifyGray.opacity(0.001) : Color.spotifyGray.opacity(0.5))
                    .clipShape(Circle())
                    .onTapGesture {
                        // Handle back
                        dismiss()
                    }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.spotifyWhite)
            .animation(.smooth(duration: 0.3), value: showHeader)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            await getProduct()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getProduct() async {
        do {
            products = try await Database().getProducts()
        } catch {
            print("Failed to fetch products.")
        }
    }
}

#Preview {
    NavigationStack {
        SpotifyPlaylistView()
    }
}
