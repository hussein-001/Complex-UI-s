//
//  ContentView.swift
//  Spotify
//
//  Created by Hussien Awada on 27/06/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(products) { product in
                    Text(product.title)
                }
            }
        }
        .padding()
        .task {
            await getData()
        }
    }
    
    private func getData() async  {
        do {
            users = try await Database().getUsers()
            products = try await Database().getProducts()
            print(users.count)
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
