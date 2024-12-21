import Foundation

/// Real implementation of `HeroesRepositoryProtocol`.
final class DefaultHeroesRepository: HeroesRepositoryProtocol {
    private var network: NetworkHeroesProtocol

    /// Initializes the repository with a network service.
    /// - Parameter network: A service conforming to `NetworkHeroesProtocol`. Defaults to `NetworkHeroes()`.
    init(network: NetworkHeroesProtocol = NetworkHeroes()) {
        self.network = network
    }

    func getAllHeroes() async -> [ResultHero]? {
        return await network.fetchAllHeroes()
    }
}

/// Mock implementation of `HeroesRepositoryProtocol` for testing.
final class DefaultHeroesRepositoryMock: HeroesRepositoryProtocol {
    private var network: NetworkHeroesProtocol

    /// Initializes the mock repository with a mock network service.
    /// - Parameter network: A mock service conforming to `NetworkHeroesProtocol`. Defaults to `NetworkHeroesMock()`.
    init(network: NetworkHeroesProtocol = NetworkHeroesMock()) {
        self.network = network
    }

    func getAllHeroes() async -> [ResultHero]? {
        return await network.fetchAllHeroes()
    }
}
