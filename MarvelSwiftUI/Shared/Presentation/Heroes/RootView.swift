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
                HeroListContent()
            }
            
        case .error(message: let message):
            withAnimation {
                ErrorView(message: message)
            }
        }
    }
}

#Preview {
    let vm = HeroListViewModel(useCase: HeroesUseCaseMock())
    
    
    RootView()
        .environment(vm) // Configuración del ViewModel en el entorno
}

