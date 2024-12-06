import Foundation

// Protocolo para manejar llamadas a la API de Marvel relacionadas con héroes
protocol NetworkHeroesProtocol {
    func fetchAllHeroes(offset: Int, limit: Int) async -> (heroes: [ResultHero], total: Int)?
}

// Implementación de la clase
final class NetworkHeroes: NetworkHeroesProtocol {
    func fetchAllHeroes(offset: Int, limit: Int) async -> (heroes: [ResultHero], total: Int)? {
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(Endpoints.allHeroes.rawValue)"
        guard var urlComponents = URLComponents(string: urlCad) else {
            NSLog("Error: URL inválida: \(urlCad)")
            return nil
        }
        
        // Añadimos los parámetros de autenticación
        urlComponents.queryItems = HttpMethods.MarvelAuth.authParameters().map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        // Añadimos los parámetros de paginación
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ])
        
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
                        return (heroes: heroResponse.data.results, total: heroResponse.data.total)
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
    func fetchAllHeroes(offset: Int, limit: Int) async -> (heroes: [ResultHero], total: Int)? {
        // Simular un retraso de 1 segundo
        try? await Task.sleep(nanoseconds: 2_000_000_000) // 1 segundo en nanosegundos
        
        // Generar héroes de prueba basados en el offset y el limit
        let mockHeroes = (0..<limit).map { index in
            ResultHero(
                id: offset + index,
                name: "Mock Hero \(offset + index)",
                description: "A mock hero description.",
                modified: Date(), // Simulación de fecha
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
        
        return (heroes: mockHeroes, total: 100) // Total simulado
    }
}
