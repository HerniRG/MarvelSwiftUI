//
//  HeroListContent.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 8/12/24.
//

import SwiftUI

struct HeroListContent: View {
    @Environment(HeroListViewModel.self) var viewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.heroes, id: \.id) { hero in
                    HeroRow(hero: hero)
                        .onAppear {
                            if viewModel.heroes.last?.id == hero.id {
                                viewModel.loadMoreHeroes()
                            }
                        }
                }
                
                if viewModel.state == .loading {
                    HStack {
                        Spacer()
                        ProgressView("Loading more...")
                            .progressViewStyle(CircularProgressViewStyle())
                        Spacer()
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
        }
    }
}
