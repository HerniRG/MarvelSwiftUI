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
    @State private var viewModel = HeroListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Heroes...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            viewModel.fetchHeroes()
                        }
                        .padding()
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 24) {
                            ForEach(viewModel.heroes, id: \.id) { hero in
                                HeroRow(hero: hero)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8) // Separación inicial
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
