import Foundation

/// Protocol for handling Marvel API calls related to heroes.
protocol NetworkHeroesProtocol {
    /// Fetches all Marvel heroes.
    /// - Returns: An array of `ResultHero` if successful, otherwise `nil`.
    func fetchAllHeroes() async -> [ResultHero]?
}

/// Implementation of `NetworkHeroesProtocol` for fetching heroes from the Marvel API.
final class NetworkHeroes: NetworkHeroesProtocol {
    /// Fetches all Marvel heroes from the API.
    /// - Returns: An array of `ResultHero` if the request is successful, otherwise `nil`.
    func fetchAllHeroes() async -> [ResultHero]? {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.allHeroes.rawValue)"
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
            let heroResponse = try decoder.decode(Heroe.self, from: data)
            return heroResponse.data.results
        } catch {
            NSLog("Failed to fetch heroes: \(error.localizedDescription)")
            return nil
        }
    }
}

/// Mock implementation of `NetworkHeroesProtocol` for testing purposes.
final class NetworkHeroesMock: NetworkHeroesProtocol {
    /// Sample mock heroes.
    static let mockHeroes: [ResultHero] = (0..<100).map { index in
        ResultHero(
            id: index,
            name: "Mock Hero \(index)",
            description: "A mock hero description.",
            modified: Date(),
            thumbnail: ThumbnailHero(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                thumbnailExtension: .jpg
            ),
            resourceURI: "",
            comics: ComicsHero(available: 10, collectionURI: "", items: [], returned: 0),
            series: ComicsHero(available: 5, collectionURI: "", items: [], returned: 0),
            stories: StoriesHero(available: 3, collectionURI: "", items: [], returned: 0),
            events: ComicsHero(available: 2, collectionURI: "", items: [], returned: 0),
            urls: []
        )
    }

    /// Returns mock heroes after a simulated delay.
    /// - Returns: An array of `ResultHero`.
    func fetchAllHeroes() async -> [ResultHero]? {
        try? await Task.sleep(nanoseconds: 2_000_000_000) // 2-second delay
        return Self.mockHeroes
    }
}
