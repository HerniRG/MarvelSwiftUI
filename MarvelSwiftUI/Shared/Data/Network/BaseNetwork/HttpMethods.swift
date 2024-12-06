//
//  HttpMethods.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//


import Foundation
import CryptoKit

/// Métodos HTTP y configuración para la API de Marvel
struct HttpMethods {
    static let post = "POST" // Método POST
    static let get = "GET"   // Método GET
    
    // Tipo de contenido para las solicitudes
    static let content = "application/json"
    static let contentTypeID = "Content-Type"
    
    /// Parámetros necesarios para la autenticación de Marvel API
    struct MarvelAuth {
        static let publicKey = ConstantsApp.CONS_API_PUBLIC_KEY // Clave pública
        static let privateKey = ConstantsApp.CONS_API_PRIVATE_KEY // Clave privada
        static let timestamp = "\(Int(Date().timeIntervalSince1970))" // Timestamp dinámico

        /// Genera el hash requerido para las solicitudes de Marvel
        static func generateHash() -> String {
            let input = "\(timestamp)\(privateKey)\(publicKey)"
            return input.md5() // md5 genera el hash del input
        }

        /// Parámetros de autenticación en formato clave-valor
        static func authParameters() -> [String: String] {
            return [
                "apikey": publicKey,
                "ts": timestamp,
                "hash": generateHash()
            ]
        }
    }
}

/// Extensión para calcular el hash MD5 usando CryptoKit
extension String {
    func md5() -> String {
        let inputData = Data(self.utf8)
        let hashed = Insecure.MD5.hash(data: inputData)
        return hashed.map { String(format: "%02x", $0) }.joined()
    }
}
