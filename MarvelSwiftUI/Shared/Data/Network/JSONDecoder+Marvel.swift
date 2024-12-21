import Foundation

extension JSONDecoder {
    /// Creates a JSONDecoder configured to decode Marvel API date formats.
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
                NSLog("Unknown date format: \(dateString). Assigning Date.distantPast.")
                return Date.distantPast
            }
        }
        return decoder
    }
}
