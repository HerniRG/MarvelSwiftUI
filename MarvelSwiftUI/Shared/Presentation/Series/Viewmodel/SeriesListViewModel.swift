//
//  SeriesListViewModel.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//

import Foundation
import Combine

@Observable
final class SeriesListViewModel {
    var series: [Result] = []
    var isLoading: Bool = false
    var errorMessage: String?
    private var totalSeries: Int = 0
    private var currentOffset: Int = 0
    private let limit: Int = 20

    private let useCase: SeriesUseCaseProtocol

    init(useCase: SeriesUseCaseProtocol = SeriesUseCase()) {
        self.useCase = useCase
    }

    @MainActor
    func fetchSeries(for characterId: String) {
        guard !isLoading else { return } // Evita múltiples cargas simultáneas
        isLoading = true
        errorMessage = nil

        Task {
            do {
                if let response = await useCase.getHeroSeries(characterId: characterId, offset: currentOffset, limit: limit) {
                    if response.isEmpty && currentOffset == 0 {
                        errorMessage = "No series found for this hero."
                        NSLog("Error: La lista de series está vacía.")
                    } else {
                        series.append(contentsOf: response)
                        currentOffset += response.count // Incrementa el offset con el número de series obtenidas
                        totalSeries += response.count // Si tienes acceso al total desde la API, actualízalo aquí
                    }
                } else {
                    errorMessage = "Failed to load series: Response is nil."
                    NSLog("Error: El caso de uso devolvió nil.")
                }
            }

            isLoading = false
        }
    }

    @MainActor
    func loadMoreSeries(for characterId: String) {
        guard currentOffset < totalSeries && !isLoading else { return } // Evita cargar si ya obtuviste todas las series
        fetchSeries(for: characterId)
    }
}
