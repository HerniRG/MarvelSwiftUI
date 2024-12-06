//
//  HeroesRepositoryProtocol.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation

/// Protocolo para manejar las solicitudes relacionadas con los héroes
protocol HeroesRepositoryProtocol {
    /// Obtiene todos los héroes disponibles desde la API de Marvel
    /// - Returns: Una lista de héroes (`[ResultHero]`) o `nil` si ocurre un error.
    func getAllHeroes() async -> [ResultHero]?
}