//
//  Endpoints.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation

/// Endpoints de la API de Marvel
enum Endpoints: String {
    case allHeroes = "/characters" // Obtener todos los héroes
    case heroSeries = "/characters/{characterId}/series" // Series de un héroe específico
}
