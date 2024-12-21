import Foundation

/// Marvel API endpoints.
enum Endpoints: String {
    case allHeroes = "/characters" // Fetch all heroes
    case heroSeries = "/characters/{characterId}/series" // Fetch a hero's series
}
