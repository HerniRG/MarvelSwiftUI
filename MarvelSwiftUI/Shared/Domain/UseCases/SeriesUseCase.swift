//
//  SeriesUseCaseProtocol.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//

import Foundation

/// Protocol for handling use cases related to series.
protocol SeriesUseCaseProtocol {
    /// The repository for fetching series.
    var repo: SeriesRepositoryProtocol { get set }
    
    /// Fetches series associated with a specific hero.
    /// - Parameter characterId: The unique identifier of the hero.
    /// - Returns: An array of `ResultSeries` or `nil` if an error occurs.
    func getHeroSeries(characterId: String) async -> [ResultSeries]?
}

/// Implementation of the series use case.
final class SeriesUseCase: SeriesUseCaseProtocol {
    var repo: SeriesRepositoryProtocol

    /// Initializes the use case with a series repository.
    /// - Parameter repo: A repository conforming to `SeriesRepositoryProtocol`. Defaults to `DefaultSeriesRepository()`.
    init(repo: SeriesRepositoryProtocol = DefaultSeriesRepository()) {
        self.repo = repo
    }

    func getHeroSeries(characterId: String) async -> [ResultSeries]? {
        return await repo.getHeroSeries(characterId: characterId)
    }
}

/// Mock implementation of `SeriesUseCaseProtocol` for testing.
final class SeriesUseCaseMock: SeriesUseCaseProtocol {
    var repo: SeriesRepositoryProtocol

    /// Initializes the mock use case with a mock series repository.
    /// - Parameter repo: A mock repository conforming to `SeriesRepositoryProtocol`. Defaults to `DefaultSeriesRepositoryMock()`.
    init(repo: SeriesRepositoryProtocol = DefaultSeriesRepositoryMock()) {
        self.repo = repo
    }

    func getHeroSeries(characterId: String) async -> [ResultSeries]? {
        return await repo.getHeroSeries(characterId: characterId)
    }
}
