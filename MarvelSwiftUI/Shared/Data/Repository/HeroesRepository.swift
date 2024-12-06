//
//  HeroesRepository.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation

// Implementación Real
final class DefaultHeroesRepository: HeroesRepositoryProtocol {
    private var network: NetworkHeroesProtocol

    init(network: NetworkHeroesProtocol = NetworkHeroes()) {
        self.network = network
    }

    func getAllHeroes() async -> [ResultHero]? {
        return await network.fetchAllHeroes()
    }
}

// Mock
final class DefaultHeroesRepositoryMock: HeroesRepositoryProtocol {
    private var network: NetworkHeroesProtocol

    init(network: NetworkHeroesProtocol = NetworkHeroesMock()) {
        self.network = network
    }

    func getAllHeroes() async -> [ResultHero]? {
        return await network.fetchAllHeroes()
    }
}
