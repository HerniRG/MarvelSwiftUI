//
//  NetworkSeries.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//

import Foundation

// Protocolo para manejar llamadas a la API de Marvel relacionadas con series de héroes
protocol NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String) async -> [Result]?
}

// Implementación de la clase
final class NetworkSeries: NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String) async -> [Result]? {
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(Endpoints.heroSeries.rawValue)".replacingOccurrences(of: "{characterId}", with: characterId)
        guard var urlComponents = URLComponents(string: urlCad) else { return nil }
        
        // Añadimos los parámetros de autenticación
        urlComponents.queryItems = HttpMethods.MarvelAuth.authParameters().map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        // Verificamos que la URL sea válida
        guard let url = urlComponents.url else { return nil }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        // Llamada al servidor
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse, resp.statusCode == HttpResponseCodes.success {
                let seriesResponse = try JSONDecoder().decode(Series.self, from: data)
                return seriesResponse.data.results
            }
        } catch {
            print("Error al obtener las series del héroe: \(error.localizedDescription)")
        }
        
        return nil
    }
}

// Mock para pruebas
final class NetworkSeriesMock: NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String) async -> [Result]? {
        return [
            Result(
                id: 1,
                title: "Avengers Series",
                description: "A test series",
                resourceURI: "https://marvel.com/series/1",
                urls: [
                    URLElement(type: "detail", url: "https://marvel.com/series/1/details")
                ],
                startYear: 2024,
                endYear: 2025,
                rating: "PG",
                type: "Comic",
                modified: Date(),
                thumbnail: Thumbnail(
                    path: "https://example.com/image",
                    thumbnailExtension: "jpg"
                ),
                creators: Creators(
                    available: 1,
                    collectionURI: "https://marvel.com/creators",
                    items: [
                        CreatorsItem(
                            resourceURI: "https://marvel.com/creator/1",
                            name: "John Doe",
                            role: "Writer"
                        )
                    ],
                    returned: 1
                ),
                characters: Characters(
                    available: 1,
                    collectionURI: "https://marvel.com/characters",
                    items: [
                        CharactersItem(
                            resourceURI: "https://marvel.com/character/1",
                            name: "Spider-Man"
                        )
                    ],
                    returned: 1
                ),
                stories: Stories(
                    available: 1,
                    collectionURI: "https://marvel.com/stories",
                    items: [
                        StoriesItem(
                            resourceURI: "https://marvel.com/story/1",
                            name: "Story Title",
                            type: .cover
                        )
                    ],
                    returned: 1
                ),
                comics: Characters(
                    available: 1,
                    collectionURI: "https://marvel.com/comics",
                    items: [
                        CharactersItem(
                            resourceURI: "https://marvel.com/comic/1",
                            name: "Avengers #1"
                        )
                    ],
                    returned: 1
                ),
                events: Characters(
                    available: 1,
                    collectionURI: "https://marvel.com/events",
                    items: [
                        CharactersItem(
                            resourceURI: "https://marvel.com/event/1",
                            name: "Infinity War"
                        )
                    ],
                    returned: 1
                ),
                next: nil,
                previous: nil
            )
        ]
    }
}
