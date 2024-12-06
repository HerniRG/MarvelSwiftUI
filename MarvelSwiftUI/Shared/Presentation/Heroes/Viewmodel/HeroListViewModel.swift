//
//  HeroListViewModel.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation
import Combine

@Observable
final class HeroListViewModel {
    var heroes: [ResultHero] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let useCase: HeroesUseCaseProtocol

    init(useCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCase = useCase
    }

    @MainActor
    func fetchHeroes() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                if let fetchedHeroes = await useCase.getAllHeroes() {
                    if fetchedHeroes.isEmpty {
                        errorMessage = "No heroes found."
                        NSLog("Error: La lista de héroes está vacía.")
                    } else {
                        heroes = fetchedHeroes
                    }
                } else {
                    errorMessage = "Failed to load heroes: Response is nil."
                    NSLog("Error: El caso de uso devolvió nil.")
                }
            }
            
            isLoading = false
        }
    }
}
