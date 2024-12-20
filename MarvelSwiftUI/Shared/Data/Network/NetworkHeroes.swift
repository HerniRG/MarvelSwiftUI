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
        
        // Añadimos los parámetros de autenticación usando los valores fijos
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
                let heroResponse = try decoder.decode(Heroe.self, from: data)
                return heroResponse.data.results
            } else {
                NSLog("Error HTTP: Código \(resp.statusCode)")
            }
        } catch {
            NSLog("Error al obtener los héroes: \(error.localizedDescription)")
        }
        
        return nil
    }
}

// Mock para pruebas
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
        // Simular retraso de 2s sin logs
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return Self.mockHeroes
    }
}
