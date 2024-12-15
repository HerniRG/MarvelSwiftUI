//
//  SeriesUseCaseProtocol.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation

import Foundation

/// Protocolo para manejar los casos de uso relacionados con las series
protocol SeriesUseCaseProtocol {
    var repo: SeriesRepositoryProtocol { get set }
    
    /// Obtiene las series asociadas a un héroe
    /// - Parameter characterId: El identificador del héroe.
    /// - Returns: Una lista de series (`[Result]`) o `nil` en caso de error.
    func getHeroSeries(characterId: String) async -> [ResultSeries]?
}

/// Implementación del caso de uso de series
final class SeriesUseCase: SeriesUseCaseProtocol {
    var repo: SeriesRepositoryProtocol

    init(repo: SeriesRepositoryProtocol = DefaultSeriesRepository()) {
        self.repo = repo
    }

    func getHeroSeries(characterId: String) async -> [ResultSeries]? {
        return await repo.getHeroSeries(characterId: characterId)
    }
}

final class SeriesUseCaseMock: SeriesUseCaseProtocol {
    var repo: SeriesRepositoryProtocol

    init(repo: SeriesRepositoryProtocol = DefaultSeriesRepositoryMock()) {
        self.repo = repo
    }

    func getHeroSeries(characterId: String) async -> [ResultSeries]? {
        return await repo.getHeroSeries(characterId: characterId)
    }
}
