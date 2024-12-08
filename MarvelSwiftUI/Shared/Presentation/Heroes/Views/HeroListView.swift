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
                    LoadingView()
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error) {
                        viewModel.fetchHeroes(reset: true)
                    }
                } else {
                    HeroListContent(
                        heroes: viewModel.heroes,
                        isLoading: viewModel.isLoading
                    ) {
                        viewModel.loadMoreHeroes()
                    }
                }
            }
            .navigationTitle("Marvel Heroes")
        }
        .onAppear {
            viewModel.fetchHeroesIfNeeded()
        }
    }
}
