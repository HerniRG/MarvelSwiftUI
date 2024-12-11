//
//  ErrorView.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 8/12/24.
//

import SwiftUI

struct ErrorView: View {
    @Environment(HeroListViewModel.self) var viewmodel
    
    private var message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        VStack {
            Text("Error: \(message)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
            Button("Retry") {
                Task {
                    await viewmodel.fetchHeroes()
                }
            }
            .buttonStyle(BorderedButtonStyle())
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
