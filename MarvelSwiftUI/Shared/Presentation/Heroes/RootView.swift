//
//  RootView.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 8/12/24.
//


import SwiftUI

struct RootView: View {
    @Environment(HeroListViewModel.self) var viewModel
    
    var body: some View {
        
        switch viewModel.state {
        case .loading:
            withAnimation {
                LoadingView()
            }
            
        case .loaded:
            withAnimation {
                HeroListView()
            }
            
        case .error(message: let message):
            withAnimation {
                ErrorView(message: message)
            }
        }
    }
}

#Preview {
    RootView()
        .environment(HeroListViewModel()) // Configuración del ViewModel en el entorno
}

