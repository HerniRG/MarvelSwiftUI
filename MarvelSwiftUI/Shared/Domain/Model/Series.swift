import Foundation

// MARK: - SeriesResponse
struct SeriesResponse: Codable {
    let code: Int
    let status: String
    let data: DataClassSeries
}

// MARK: - DataClassSeries
struct DataClassSeries: Codable {
    let offset, limit, total, count: Int
    let results: [ResultSeries]
}

// MARK: - ResultSeries
struct ResultSeries: Codable {
    let id: Int
    let title: String
    let description: String?
    let resourceURI: String
    let urls: [URLElement]
    let startYear: Int
    let endYear: Int
    let rating: String?
    let type: String?
    let modified: Date
    let thumbnail: Thumbnail
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let comics: Characters
    let events: Characters
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

    // Formato fijo para imágenes verticales
    private let defaultVariantVertical = "portrait_uncanny"

    // Método para obtener la URL con formato fijo
    var verticalUrl: String {
        return "\(path)/\(defaultVariantVertical).\(thumbnailExtension)"
    }

    // Método para obtener la URL original
    var originalUrl: String {
        return "\(path).\(thumbnailExtension)"
    }
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

struct CreatorsItem: Codable {
    let resourceURI: String
    let name: String
    let role: String
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharactersItem]
    let returned: Int
}

struct CharactersItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}
