import Foundation

extension JSONDecoder {
    static func marvelDateDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            formatter.locale = Locale(identifier: "en_US_POSIX")

            if let date = formatter.date(from: dateString) {
                return date
            } else if dateString == "-0001-11-30T00:00:00-0500" {
                return Date.distantPast
            } else {
                NSLog("Formato de fecha desconocido: \(dateString), asignando Date.distantPast.")
                return Date.distantPast
            }
        }
        return decoder
    }
}
