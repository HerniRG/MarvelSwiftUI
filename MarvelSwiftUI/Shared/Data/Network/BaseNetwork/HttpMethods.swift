import Foundation

/// HTTP methods and related constants for API requests.
struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let content = "application/json"
    static let contentTypeHeader = "Content-Type"
    
    /// Authentication parameters with fixed values.
    struct MarvelAuth {
        static func authParameters() -> [String: String] {
            [
                "apikey": ConstantsApp.CONS_API_PUBLIC_KEY,
                "ts": ConstantsApp.CONS_API_TS,
                "hash": ConstantsApp.CONS_API_HASH
            ]
        }
    }
}
