import Foundation

struct HttpMethods {
    static let post = "POST"
    static let get = "GET"
    static let content = "application/json"
    static let contentTypeID = "Content-Type"
    
    /// Parámetros de autenticación usando valores fijos
    struct MarvelAuth {
        static func authParameters() -> [String: String] {
            return [
                "apikey": ConstantsApp.CONS_API_PUBLIC_KEY,
                "ts": ConstantsApp.CONS_API_TS,
                "hash": ConstantsApp.CONS_API_HASH
            ]
        }
    }
}
