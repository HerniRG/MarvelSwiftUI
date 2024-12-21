import Foundation

/// Real implementation of `SeriesRepositoryProtocol`.
final class DefaultSeriesRepository: SeriesRepositoryProtocol {
    private var network: NetworkSeriesProtocol

    /// Initializes the repository with a network service.
    /// - Parameter network: A service conforming to `NetworkSeriesProtocol`. Defaults to `NetworkSeries()`.
    init(network: NetworkSeriesProtocol = NetworkSeries()) {
        self.network = network
    }

    func getHeroSeries(characterId: String) async -> [ResultSeries]? {
        return await network.fetchHeroSeries(characterId: characterId)
    }
}

/// Mock implementation of `SeriesRepositoryProtocol` for testing.
final class DefaultSeriesRepositoryMock: SeriesRepositoryProtocol {
    private var network: NetworkSeriesProtocol

    /// Initializes the mock repository with a mock network service.
    /// - Parameter network: A mock service conforming to `NetworkSeriesProtocol`. Defaults to `NetworkSeriesMock()`.
    init(network: NetworkSeriesProtocol = NetworkSeriesMock()) {
        self.network = network
    }

    func getHeroSeries(characterId: String) async -> [ResultSeries]? {
        return await network.fetchHeroSeries(characterId: characterId)
    }
}
