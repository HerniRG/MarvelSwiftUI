import Foundation

// Protocolo para manejar llamadas a la API de Marvel relacionadas con héroes
protocol NetworkHeroesProtocol {
    func fetchAllHeroes() async -> [ResultHero]?
}

// Implementación de la clase
final class NetworkHeroes: NetworkHeroesProtocol {
    func fetchAllHeroes() async -> [ResultHero]? {
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(Endpoints.allHeroes.rawValue)"
        guard var urlComponents = URLComponents(string: urlCad) else {
            NSLog("Error: URL inválida: \(urlCad)")
            return nil
        }
        
        // Añadimos los parámetros de autenticación
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
                // Log del JSON recibido (opcional en producción)
                if let jsonString = String(data: data, encoding: .utf8) {
                    NSLog("JSON recibido: \(jsonString)")
                }

                // Configurar decodificador
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                // Decodificar JSON
                let heroResponse = try decoder.decode(Heroe.self, from: data)
                NSLog("Héroes obtenidos: \(heroResponse.data.results.count)")
                return heroResponse.data.results
            } else {
                NSLog("Error HTTP: Código \(response as? HTTPURLResponse)?.statusCode ?? 0")
            }
        } catch {
            NSLog("Error al obtener los héroes: \(error.localizedDescription)")
        }
        
        return nil
    }
}

// Mock para pruebas
/// Mock de `NetworkHeroes` para pruebas sin depender de una conexión de red.
final class NetworkHeroesMock: NetworkHeroesProtocol {
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

    func fetchAllHeroes() async -> [ResultHero]? {
        try? await Task.sleep(nanoseconds: 2_000_000_000) // Simular retraso de 2s
        print("Mock use case called") // Log para confirmar ejecución
        return Self.mockHeroes
    }
}
