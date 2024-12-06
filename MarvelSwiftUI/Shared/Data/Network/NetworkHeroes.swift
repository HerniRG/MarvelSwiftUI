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

        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.get

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                NSLog("Código de respuesta HTTP: \(resp.statusCode)")
                if resp.statusCode == HttpResponseCodes.success {
                    // Log del JSON recibido
                    if let jsonString = String(data: data, encoding: .utf8) {
                        NSLog("JSON recibido: \(jsonString)")
                    }

                    // Configurar decodificador
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601 // Manejo de fechas ISO 8601

                    // Decodificar JSON
                    do {
                        let heroResponse = try decoder.decode(Heroe.self, from: data)
                        NSLog("Héroes obtenidos: \(heroResponse.data.results.count)")
                        return heroResponse.data.results
                    } catch {
                        NSLog("Error al decodificar la respuesta: \(error.localizedDescription)")
                        NSLog("Respuesta JSON: \(String(data: data, encoding: .utf8) ?? "Datos no válidos")")
                    }
                } else {
                    NSLog("Error HTTP: Código \(resp.statusCode)")
                }
            }
        } catch {
            NSLog("Error al obtener los héroes: \(error.localizedDescription)")
        }
        
        return nil
    }
}

// Mock para pruebas
final class NetworkHeroesMock: NetworkHeroesProtocol {
    func fetchAllHeroes() async -> [ResultHero]? {
        return [
            ResultHero(
                id: 1011334,
                name: "3-D Man",
                description: "A classic Marvel character with unique powers.",
                modified: Date(), // Simulación de fecha
                thumbnail: ThumbnailHero(
                    path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                    thumbnailExtension: .jpg
                ),
                resourceURI: "",
                comics: ComicsHero(available: 12, collectionURI: "", items: [], returned: 0),
                series: ComicsHero(available: 3, collectionURI: "", items: [], returned: 0),
                stories: StoriesHero(available: 5, collectionURI: "", items: [], returned: 0),
                events: ComicsHero(available: 1, collectionURI: "", items: [], returned: 0),
                urls: []
            )
        ]
    }
}
