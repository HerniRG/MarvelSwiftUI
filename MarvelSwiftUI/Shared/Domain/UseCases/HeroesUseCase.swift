import Foundation

/// Protocol for handling use cases related to heroes.
protocol HeroesUseCaseProtocol {
    /// The repository for fetching heroes.
    var repo: HeroesRepositoryProtocol { get set }
    
    /// Fetches all available heroes.
    /// - Returns: An array of `ResultHero` or `nil` if an error occurs.
    func getAllHeroes() async -> [ResultHero]?
}

/// Implementation of the heroes use case.
final class HeroesUseCase: HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol

    /// Initializes the use case with a heroes repository.
    /// - Parameter repo: A repository conforming to `HeroesRepositoryProtocol`. Defaults to `DefaultHeroesRepository()`.
    init(repo: HeroesRepositoryProtocol = DefaultHeroesRepository()) {
        self.repo = repo
    }

    func getAllHeroes() async -> [ResultHero]? {
        return await repo.getAllHeroes()
    }
}

/// Mock implementation of `HeroesUseCaseProtocol` for testing.
final class HeroesUseCaseMock: HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol

    /// Initializes the mock use case with a mock heroes repository.
    /// - Parameter repo: A mock repository conforming to `HeroesRepositoryProtocol`. Defaults to `DefaultHeroesRepositoryMock()`.
    init(repo: HeroesRepositoryProtocol = DefaultHeroesRepositoryMock()) {
        self.repo = repo
    }

    func getAllHeroes() async -> [ResultHero]? {
        return await repo.getAllHeroes()
    }
}
