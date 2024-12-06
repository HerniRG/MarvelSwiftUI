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
    var totalHeroes: Int = 0
    private var limit: Int = 20
    private var currentOffset: Int = 0

    private let useCase: HeroesUseCaseProtocol

    init(useCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCase = useCase
    }

    @MainActor
    func fetchHeroes(offset: Int? = nil) {
        // Se usa el offset pasado como parámetro o el valor actual de currentOffset
        let newOffset = offset ?? currentOffset

        isLoading = true
        errorMessage = nil

        Task {
            do {
                // Llamar al caso de uso con el offset y limit
                if let result = await useCase.getAllHeroes(offset: newOffset, limit: limit) {
                    if result.heroes.isEmpty {
                        errorMessage = "No heroes found."
                        NSLog("Error: La lista de héroes está vacía.")
                    } else {
                        // Si la lista no está vacía, actualizamos los héroes
                        if newOffset == 0 {
                            heroes = result.heroes // Si es la primera página, reemplazamos la lista
                        } else {
                            heroes.append(contentsOf: result.heroes) // Si no es la primera, agregamos más héroes
                        }
                        currentOffset = newOffset + result.heroes.count // Actualizar el offset con el número de héroes obtenidos
                        totalHeroes = result.total // Actualizar el total de héroes
                    }
                } else {
                    errorMessage = "Failed to load heroes: Response is nil."
                    NSLog("Error: El caso de uso devolvió nil.")
                }
            }
            
            isLoading = false
        }
    }

    /// Cargar la siguiente página de héroes
    @MainActor
    func loadMoreHeroes() {
        if currentOffset < totalHeroes {
            fetchHeroes(offset: currentOffset) // Llamar a la función con el siguiente offset
        }
    }
}
