//
//  HeroListView.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//

import SwiftUI
import Combine

// MARK: - HeroListView
struct HeroListView: View {
    @State private var viewModel = HeroListViewModel() // Usamos @State para el ViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.heroes.isEmpty {
                    ProgressView("Loading Heroes...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            viewModel.fetchHeroes() // Reintentar la carga de héroes
                        }
                        .padding()
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            ForEach(viewModel.heroes, id: \.id) { hero in
                                HeroRow(hero: hero) // Usamos la vista HeroRow que ya tienes
                                    .onAppear {
                                        handleHeroAppear(hero: hero)
                                    }
                            }

                            if viewModel.isLoading && viewModel.heroes.count < viewModel.totalHeroes {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .padding()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8) // Separación inicial
                    }
                }
            }
            .navigationTitle("Marvel Heroes")
            .onAppear {
                viewModel.fetchHeroes() // Cargar héroes al aparecer la vista
            }
        }
    }

    // Función para manejar la aparición de los héroes
    private func handleHeroAppear(hero: ResultHero) {
        if let lastHero = viewModel.heroes.last, lastHero.id == hero.id {
            viewModel.loadMoreHeroes() // Cargar más héroes cuando llegamos al final
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
