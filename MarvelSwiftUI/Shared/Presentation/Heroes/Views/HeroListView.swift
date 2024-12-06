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
            Group {
                if viewModel.isLoading && viewModel.heroes.isEmpty {
                    ProgressView("Loading Heroes...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error) {
                        viewModel.fetchHeroes(reset: true)
                    }
                } else {
                    HeroList(heroes: viewModel.heroes) {
                        viewModel.loadMoreHeroes()
                    }
                }
            }
            .navigationTitle("Marvel Heroes")
            .onAppear {
                viewModel.fetchHeroes()
            }
        }
    }
}

// MARK: - Subviews

struct HeroList: View {
    let heroes: [ResultHero]
    let onLoadMore: () -> Void

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(heroes, id: \.id) { hero in
                    VStack {
                        HeroRow(hero: hero)
                            .onAppear {
                                if heroes.last?.id == hero.id {
                                    onLoadMore()
                                }
                            }
                        if heroes.last?.id == hero.id {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }
}

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
