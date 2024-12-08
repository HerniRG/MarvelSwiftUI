//
//  HeroListView.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//

import SwiftUI

struct HeroListView: View {
    @Environment(HeroListViewModel.self) var viewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                LoadingView() // Pantalla de carga
                
            case .loaded:
                NavigationView {
                    HeroListContent()
                        .navigationTitle("Marvel Heroes")
                }
                
            case .error(let message):
                ErrorView(message: message)
            }
        }
        .onAppear {
            viewModel.fetchHeroesIfNeeded()
        }
    }
}

struct HeroListView_Previews: PreviewProvider {
    static var previews: some View {
        HeroListView()
    }
}
