//
//  HeroesUseCaseProtocol.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation

/// Protocolo para manejar los casos de uso relacionados con los héroes
protocol HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol { get set }
    
    /// Obtiene todos los héroes disponibles
    /// - Returns: Una lista de héroes (`[ResultHero]`) o `nil` en caso de error.
    func getAllHeroes() async -> [ResultHero]?
}

/// Implementación del caso de uso de héroes
final class HeroesUseCase: HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol

    init(repo: HeroesRepositoryProtocol = DefaultHeroesRepository()) {
        self.repo = repo
    }

    func getAllHeroes() async -> [ResultHero]? {
        return await repo.getAllHeroes()
    }
}