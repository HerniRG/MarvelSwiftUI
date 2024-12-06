//
//  HttpResponseCodes.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation

/// Códigos de respuesta HTTP para manejar respuestas de la API de Marvel
struct HttpResponseCodes {
    static let success = 200              // Solicitud exitosa
    static let created = 201              // Recurso creado correctamente
    static let unauthorized = 401         // No autorizado (problemas de autenticación)
    static let forbidden = 403            // Prohibido (acceso denegado)
    static let notFound = 404             // Recurso no encontrado
    static let internalServerError = 500  // Error interno del servidor
    static let badGateway = 502           // Puerta de enlace incorrecta
    static let serviceUnavailable = 503   // Servicio no disponible
}