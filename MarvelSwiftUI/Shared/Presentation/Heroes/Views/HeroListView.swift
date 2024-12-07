//
//  HeroListView.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//

import SwiftUI

struct HeroListView: View {
    @State private var viewModel = HeroListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading && viewModel.heroes.isEmpty {
                    LoadingView()
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error) {
                        viewModel.fetchHeroes(reset: true)
                    }
                } else {
                    HeroListContent(heroes: viewModel.heroes, isLoading: viewModel.isLoading) {
                        viewModel.loadMoreHeroes()
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Marvel Heroes")
            .onAppear {
                viewModel.fetchHeroes()
            }
        }
    }
}

// MARK: - Subview for Hero List Content
struct HeroListContent: View {
    let heroes: [ResultHero]
    let isLoading: Bool
    let onLoadMore: () -> Void

    var body: some View {
        ForEach(heroes, id: \.id) { hero in
            HeroRow(hero: hero)
                .onAppear {
                    if heroes.last?.id == hero.id {
                        onLoadMore()
                    }
                }
        }
        
        if isLoading {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Loading View
struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView("Loading Heroes...")
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

// MARK: - Error View
struct ErrorView: View {
    let message: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack {
            Text("Error: \(message)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
            Button("Retry") {
                onRetry()
            }
            .padding()
        }
    }
}

// MARK: - Preview
struct HeroListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeroListView()
                .previewDevice("iPhone 14")
            HeroListView()
                .previewDevice("iPad Pro (12.9-inch)")
            HeroListView()
                .previewDevice("Apple Watch Series 8 - 45mm")
            HeroListView()
                .frame(width: 800, height: 600) // macOS
        }
    }
}
