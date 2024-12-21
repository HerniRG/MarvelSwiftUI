import Foundation

/// Protocol for fetching series related to heroes from the Marvel API.
protocol SeriesRepositoryProtocol {
    /// Fetches series associated with a specific hero.
    /// - Parameter characterId: The unique identifier of the hero.
    /// - Returns: An array of `ResultSeries` or `nil` if an error occurs.
    func getHeroSeries(characterId: String) async -> [ResultSeries]?
}
