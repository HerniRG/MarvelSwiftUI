import Foundation

// Protocolo para manejar llamadas a la API de Marvel relacionadas con series de héroes
protocol NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String) async -> [ResultSeries]?
}

/// Implementación real de `NetworkSeriesProtocol` para manejar solicitudes de series
final class NetworkSeries: NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String) async -> [ResultSeries]? {
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(Endpoints.heroSeries.rawValue)"
            .replacingOccurrences(of: "{characterId}", with: characterId)
        
        guard var urlComponents = URLComponents(string: urlCad) else {
            NSLog("Error: URL inválida: \(urlCad)")
            return nil
        }
        
        // Añadir los parámetros de autenticación
        urlComponents.queryItems = HttpMethods.MarvelAuth.authParameters().map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = urlComponents.url else {
            NSLog("Error: URLComponents no pudo generar una URL válida.")
            return nil
        }
        
        NSLog("URL final: \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse, resp.statusCode == HttpResponseCodes.success {
                // Log del JSON recibido (opcional)
                if let jsonString = String(data: data, encoding: .utf8) {
                    NSLog("JSON recibido: \(jsonString)")
                }
                
                // Configurar decodificador
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom { decoder -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateString = try container.decode(String.self)
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Formato esperado
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    
                    if let date = formatter.date(from: dateString) {
                        return date
                    } else if dateString == "-0001-11-30T00:00:00-0500" {
                        return Date.distantPast // Manejo de fechas inválidas
                    } else {
                        NSLog("Formato de fecha desconocido: \(dateString), asignando `Date.distantPast`.")
                        return Date.distantPast
                    }
                }
                
                // Decodificar JSON
                let seriesResponse = try decoder.decode(SeriesResponse.self, from: data)
                NSLog("Series obtenidas: \(seriesResponse.data.results.count)")
                return seriesResponse.data.results
            } else {
                NSLog("Error HTTP: Código \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
        } catch {
            NSLog("Error al obtener las series: \(error.localizedDescription)")
        }
        
        return nil
    }
}

// Mock para pruebas
/// Mock de `NetworkSeriesProtocol` para pruebas sin depender de una conexión de red
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
        try? await Task.sleep(nanoseconds: 2_000_000_000) // Simular retraso de 2s
        NSLog("Mock use case called para characterId: \(characterId)")
        return Self.mockSeries
    }
}
