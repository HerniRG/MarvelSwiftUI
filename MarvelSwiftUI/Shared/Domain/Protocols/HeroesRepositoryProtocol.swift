//
//  HeroesRepositoryProtocol.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//

import Foundation

/// Protocolo para manejar las solicitudes relacionadas con los héroes
protocol HeroesRepositoryProtocol {
    /// Obtiene todos los héroes disponibles desde la API de Marvel con soporte para paginación
    /// - Parameters:
    ///   - offset: Índice de inicio de los resultados.
    ///   - limit: Número máximo de resultados a obtener.
    /// - Returns: Una tupla con:
    ///   - `heroes`: Lista de héroes obtenidos.
    ///   - `total`: Número total de héroes disponibles.
    ///   - Devuelve `nil` si ocurre un error.
    func getAllHeroes(offset: Int, limit: Int) async -> (heroes: [ResultHero], total: Int)?
}
