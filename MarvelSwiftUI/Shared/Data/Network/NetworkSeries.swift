import Foundation

/// Protocol for handling Marvel API calls related to hero series.
protocol NetworkSeriesProtocol {
    /// Fetches series for a specific hero.
    /// - Parameter characterId: The unique identifier of the character.
    /// - Returns: An array of `ResultSeries` if successful, otherwise `nil`.
    func fetchHeroSeries(characterId: String) async -> [ResultSeries]?
}

/// Real implementation of `NetworkSeriesProtocol` for fetching hero series.
final class NetworkSeries: NetworkSeriesProtocol {
    /// Fetches series for a specific hero from the Marvel API.
    /// - Parameter characterId: The unique identifier of the character.
    /// - Returns: An array of `ResultSeries` if the request is successful, otherwise `nil`.
    func fetchHeroSeries(characterId: String) async -> [ResultSeries]? {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.heroSeries.rawValue)"
            .replacingOccurrences(of: "{characterId}", with: characterId)
        
        guard var urlComponents = URLComponents(string: urlString) else {
            NSLog("Invalid URL: \(urlString)")
            return nil
        }
        
        // Add authentication parameters
        urlComponents.queryItems = HTTPMethods.MarvelAuth.authParameters().map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = urlComponents.url else {
            NSLog("Failed to generate valid URL from URLComponents.")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                NSLog("Invalid HTTP response.")
                return nil
            }
            
            guard httpResponse.statusCode == HTTPResponseCodes.success else {
                NSLog("HTTP Error: Status code \(httpResponse.statusCode)")
                return nil
            }
            
            let decoder = JSONDecoder.marvelDateDecoder()
            let seriesResponse = try decoder.decode(SeriesResponse.self, from: data)
            return seriesResponse.data.results
        } catch {
            NSLog("Failed to fetch series: \(error.localizedDescription)")
            return nil
        }
    }
}

/// Mock implementation of `NetworkSeriesProtocol` for testing purposes.
final class NetworkSeriesMock: NetworkSeriesProtocol {
    /// Sample mock series data.
    static let mockSeries: [ResultSeries] = [
        ResultSeries(
            id: 101,
            title: "Avengers Assemble",
            description: "The Earth's mightiest heroes unite!",
            resourceURI: "http://gateway.marvel.com/v1/public/series/101",
            urls: [URLElement(type: "detail", url: "http://marvel.com/series/101")],
            startYear: 2012,
            endYear: 2016,
            rating: "PG-13",
            type: "ongoing",
            modified: Date(),
            thumbnail: Thumbnail(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/c/90/515f04502b7e9",
                thumbnailExtension: "jpg"
            ),
            creators: Creators(
                available: 10,
                collectionURI: "http://gateway.marvel.com/v1/public/creators",
                items: [
                    CreatorsItem(resourceURI: "http://gateway.marvel.com/v1/public/creators/1", name: "Stan Lee", role: "Writer")
                ],
                returned: 1
            ),
            characters: Characters(
                available: 5,
                collectionURI: "http://gateway.marvel.com/v1/public/characters",
                items: [
                    CharactersItem(resourceURI: "http://gateway.marvel.com/v1/public/characters/1", name: "Iron Man")
                ],
                returned: 1
            ),
            stories: Stories(
                available: 3,
                collectionURI: "http://gateway.marvel.com/v1/public/stories",
                items: [
                    StoriesItem(resourceURI: "http://gateway.marvel.com/v1/public/stories/1", name: "Story 1", type: "cover")
                ],
                returned: 1
            ),
            comics: Characters(
                available: 10,
                collectionURI: "http://gateway.marvel.com/v1/public/comics",
                items: [],
                returned: 0
            ),
            events: Characters(
                available: 2,
                collectionURI: "http://gateway.marvel.com/v1/public/events",
                items: [],
                returned: 0
            )
        )
    ]
    
    /// Returns mock series data after a simulated delay.
    /// - Parameter characterId: The unique identifier of the character (unused in mock).
    /// - Returns: An array of `ResultSeries`.
    func fetchHeroSeries(characterId: String) async -> [ResultSeries]? {
        try? await Task.sleep(nanoseconds: 2_000_000_000) // 2-second delay
        return Self.mockSeries
    }
}
