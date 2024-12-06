//
//  SeriesRepositoryProtocol.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation

/// Protocolo para manejar las solicitudes relacionadas con las series
protocol SeriesRepositoryProtocol {
    /// Obtiene las series asociadas a un héroe específico desde la API de Marvel
    /// - Parameters:
    ///   - characterId: El identificador del héroe.
    ///   - offset: El índice inicial para la paginación.
    ///   - limit: El número máximo de resultados a obtener.
    /// - Returns: Una lista de series (`[Result]`) o `nil` si ocurre un error.
    func getHeroSeries(characterId: String, offset: Int, limit: Int) async -> [Result]?
}
