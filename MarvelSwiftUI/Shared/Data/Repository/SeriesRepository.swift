import Foundation

// Implementación Real
final class DefaultSeriesRepository: SeriesRepositoryProtocol {
    private var network: NetworkSeriesProtocol

    init(network: NetworkSeriesProtocol = NetworkSeries()) {
        self.network = network
    }

    func getHeroSeries(characterId: String) async -> [Result]? {
        return await network.fetchHeroSeries(characterId: characterId)
    }
}

// Mock
final class DefaultSeriesRepositoryMock: SeriesRepositoryProtocol {
    private var network: NetworkSeriesProtocol

    init(network: NetworkSeriesProtocol = NetworkSeriesMock()) {
        self.network = network
    }

    func getHeroSeries(characterId: String) async -> [Result]? {
        return await network.fetchHeroSeries(characterId: characterId)
    }
}
