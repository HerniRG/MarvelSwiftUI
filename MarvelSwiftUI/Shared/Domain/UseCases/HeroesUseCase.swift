//
//  HeroesUseCase.swift
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
    func getAllHeroes(offset: Int, limit: Int) async -> (heroes: [ResultHero], total: Int)?
}

/// Implementación del caso de uso de héroes
final class HeroesUseCase: HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol

    init(repo: HeroesRepositoryProtocol = DefaultHeroesRepository()) {
        self.repo = repo
    }

    func getAllHeroes(offset: Int, limit: Int) async -> (heroes: [ResultHero], total: Int)? {
        return await repo.getAllHeroes(offset: offset, limit: limit) // Pasa los parámetros offset y limit al repositorio
    }
}
