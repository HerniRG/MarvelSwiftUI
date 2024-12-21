import Foundation

/// Protocol for fetching heroes from the Marvel API.
protocol HeroesRepositoryProtocol {
    /// Fetches all available heroes.
    /// - Returns: An array of `ResultHero` or `nil` if an error occurs.
    func getAllHeroes() async -> [ResultHero]?
}
