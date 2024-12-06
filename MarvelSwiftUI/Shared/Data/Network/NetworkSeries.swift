//
//  NetworkSeries.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//

import Foundation

// Protocolo para manejar llamadas a la API de Marvel relacionadas con series de héroes
protocol NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String, offset: Int, limit: Int) async -> (series: [Result], total: Int)?
}

// Implementación de la clase
final class NetworkSeries: NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String, offset: Int, limit: Int) async -> (series: [Result], total: Int)? {
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(Endpoints.heroSeries.rawValue)"
            .replacingOccurrences(of: "{characterId}", with: characterId)

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

        // Verificamos que la URL sea válida
        guard let url = urlComponents.url else {
            NSLog("Error: URLComponents no pudo generar una URL válida.")
            return nil
        }

        NSLog("URL final: \(url.absoluteString)")

        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.get

        // Llamada al servidor
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
                        let seriesResponse = try decoder.decode(Series.self, from: data)
                        NSLog("Series obtenidas: \(seriesResponse.data.results.count)")
                        return (series: seriesResponse.data.results, total: seriesResponse.data.total)
                    } catch {
                        NSLog("Error al decodificar la respuesta: \(error.localizedDescription)")
                        NSLog("Respuesta JSON: \(String(data: data, encoding: .utf8) ?? "Datos no válidos")")
                    }
                } else {
                    NSLog("Error HTTP: Código \(resp.statusCode)")
                }
            }
        } catch {
            NSLog("Error al obtener las series: \(error.localizedDescription)")
        }

        return nil
    }
}

// Mock para pruebas
final class NetworkSeriesMock: NetworkSeriesProtocol {
    func fetchHeroSeries(characterId: String, offset: Int, limit: Int) async -> (series: [Result], total: Int)? {
        // Simular un retraso de 1 segundo
        try? await Task.sleep(nanoseconds: 2_000_000_000) // 1 segundo en nanosegundos

        // Generar series de prueba basadas en el offset y el limit
        let mockSeries = (0..<limit).map { index in
            Result(
                id: offset + index,
                title: "Mock Series \(offset + index)",
                description: "A mock series description.",
                resourceURI: "https://marvel.com/series/\(offset + index)",
                urls: [
                    URLElement(type: "detail", url: "https://marvel.com/series/\(offset + index)/details")
                ],
                startYear: 2020,
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
        }

        return (series: mockSeries, total: 100) // Total simulado
    }
}
