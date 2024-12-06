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
    /// - Parameter characterId: El identificador del héroe.
    /// - Returns: Una lista de series (`[Result]`) o `nil` si ocurre un error.
    func getHeroSeries(characterId: String) async -> [Result]?
}