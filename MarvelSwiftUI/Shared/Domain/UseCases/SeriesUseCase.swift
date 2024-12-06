//
//  SeriesUseCaseProtocol.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation

/// Protocolo para manejar los casos de uso relacionados con las series
protocol SeriesUseCaseProtocol {
    var repo: SeriesRepositoryProtocol { get set }
    
    /// Obtiene las series asociadas a un héroe
    /// - Parameters:
    ///   - characterId: El identificador del héroe.
    ///   - offset: El índice inicial para la paginación.
    ///   - limit: El número máximo de resultados a obtener.
    /// - Returns: Una lista de series (`[Result]`) o `nil` en caso de error.
    func getHeroSeries(characterId: String, offset: Int, limit: Int) async -> [Result]?
}

/// Implementación del caso de uso de series
final class SeriesUseCase: SeriesUseCaseProtocol {
    var repo: SeriesRepositoryProtocol

    init(repo: SeriesRepositoryProtocol = DefaultSeriesRepository()) {
        self.repo = repo
    }

    func getHeroSeries(characterId: String, offset: Int, limit: Int) async -> [Result]? {
        return await repo.getHeroSeries(characterId: characterId, offset: offset, limit: limit)
    }
}
