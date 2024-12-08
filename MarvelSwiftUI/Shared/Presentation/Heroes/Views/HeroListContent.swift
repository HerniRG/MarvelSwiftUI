//
//  HeroListContent.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 8/12/24.
//

import SwiftUI

struct HeroListContent: View {
    let heroes: [ResultHero]
    let isLoading: Bool
    let onLoadMore: () -> Void

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
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
