import Foundation

// Protocolo para manejar llamadas a la API de Marvel relacionadas con series de héroes
protocol NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String) async -> [ResultSeries]?
}

/// Implementación real de NetworkSeriesProtocol para manejar solicitudes de series
final class NetworkSeries: NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String) async -> [ResultSeries]? {
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(Endpoints.heroSeries.rawValue)"
            .replacingOccurrences(of: "{characterId}", with: characterId)
        
        guard var urlComponents = URLComponents(string: urlCad) else {
            NSLog("Error: URL inválida: \(urlCad)")
            return nil
        }
        
        // Añadir los parámetros de autenticación usando valores fijos
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: ConstantsApp.CONS_API_PUBLIC_KEY),
            URLQueryItem(name: "ts", value: ConstantsApp.CONS_API_TS),
            URLQueryItem(name: "hash", value: ConstantsApp.CONS_API_HASH)
        ]
        
        guard let url = urlComponents.url else {
            NSLog("Error: URLComponents no pudo generar una URL válida.")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let resp = response as? HTTPURLResponse else {
                NSLog("Error HTTP: No se pudo obtener el código de estado.")
                return nil
            }
            
            if resp.statusCode == HttpResponseCodes.success {
                let decoder = JSONDecoder.marvelDateDecoder()
                let seriesResponse = try decoder.decode(SeriesResponse.self, from: data)
                return seriesResponse.data.results
            } else {
                NSLog("Error HTTP: Código \(resp.statusCode)")
            }
        } catch {
            NSLog("Error al obtener las series: \(error.localizedDescription)")
        }
        
        return nil
    }
}

// Mock para pruebas
final class NetworkSeriesMock: NetworkSeriesProtocol {
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
    
    func fetchHeroSeries(characterId: String) async -> [ResultSeries]? {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return Self.mockSeries
    }
}
