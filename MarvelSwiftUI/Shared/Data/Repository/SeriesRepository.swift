//
//  SeriesRepository.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation

// Implementación Real
final class DefaultSeriesRepository: SeriesRepositoryProtocol {
    private var network: NetworkSeriesProtocol

    init(network: NetworkSeriesProtocol = NetworkSeries()) {
        self.network = network
    }

    func getHeroSeries(characterId: String, offset: Int, limit: Int) async -> [Result]? {
        guard let response = await network.fetchHeroSeries(characterId: characterId, offset: offset, limit: limit) else {
            return nil
        }
        return response.series // Solo devuelve la lista de series
    }
}

// Mock
final class DefaultSeriesRepositoryMock: SeriesRepositoryProtocol {
    private var network: NetworkSeriesProtocol

    init(network: NetworkSeriesProtocol = NetworkSeriesMock()) {
        self.network = network
    }

    func getHeroSeries(characterId: String, offset: Int, limit: Int) async -> [Result]? {
        guard let response = await network.fetchHeroSeries(characterId: characterId, offset: offset, limit: limit) else {
            return nil
        }
        return response.series // Solo devuelve la lista de series
    }
}
