//
//  SpotifyHomeView.swift
//  Spotify
//
//  Created by Hussien Awada on 28/06/2025.
//

import SwiftUI

struct SpotifyHomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCatgeory: Category? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100, maximum: 300)),
        GridItem(.adaptive(minimum: 100, maximum: 300))
    ]
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(alignment: .center, spacing: 20, pinnedViews: .sectionHeaders) {
                    Section {
                        VStack(spacing: 16) {
                            recentSection
                                .padding(.horizontal, 16)
                            if let product = products.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 16)
                            }
                            
                            listRows

                        }
                    } header: {
                        header
                    }
                }
            }
            .scrollIndicators(.hidden)
            .clipped()
            
        }
        .task {
            await getUser()
            await getProduct()
            await getProductRow()
        }
    }
    
    private  func getUser() async {
        do {
            currentUser = try await Database().getUsers().first
            
        } catch {
            
        }
    }
    
    private  func getProduct() async {
        do {
            products = try await Array(Database().getProducts().prefix(upTo: 8))
        } catch {
            
        }
    }
    
    private  func getProductRow() async {
        do {
            var rows: [ProductRow] = []
            let allBrands = Set(products.map( {$0.brand }))
            for brand in allBrands {
                //                let products = self.products.filter({ $0.brand == brand })
                rows.append(ProductRow(title: brand?.capitalized, products: products))
            }
            productRows = rows
        } catch {
            
        }
    }
    
    private var header: some View {
        HStack {
            ZStack {
                if let currentUser {
                    imageLoaderView(url: currentUser.image)
                        .frame(width: 30, height: 30)
                        .background(Color.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCatgeory
                        )
                        .onTapGesture {
                            selectedCatgeory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading,8)
        .frame(maxWidth: .infinity)
        .background(Color.spotifyBlack)
    }
    
    private var recentSection: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
            ForEach(products) { product in
                ProductCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                .onTapGesture {
                    
                }
            }
        }
    }
    
    private func newReleaseSection(product: Product) -> some View {
        NewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description) {
                
            } onPlayPressed: {
                
            }
    }
    
    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8) {
                Text(row.title ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top,spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                title: product.title,
                                imageName: product.firstImage,
                                imageSize: 120
                            )
                            .onTapGesture {
                                
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    SpotifyHomeView()
}
