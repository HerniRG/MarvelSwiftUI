import Foundation

// MARK: - SeriesResponse
/// Represents the response from the Marvel API for series data.
struct SeriesResponse: Codable {
    let code: Int
    let status: String
    let data: DataClassSeries
}

// MARK: - DataClassSeries
/// Contains the data for the series response.
struct DataClassSeries: Codable {
    let offset, limit, total, count: Int
    let results: [ResultSeries]
}

// MARK: - ResultSeries
/// Represents an individual Marvel series.
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
/// Represents a URL element for a series.
struct URLElement: Codable {
    let type: String
    let url: String
}

// MARK: - Thumbnail
/// Represents the thumbnail image for a series.
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

    /// Fixed format for vertical images.
    private let defaultVariantVertical = "portrait_uncanny"

    /// Constructs the URL with a fixed vertical image format.
    var verticalUrl: String {
        return "\(path)/\(defaultVariantVertical).\(thumbnailExtension)"
    }

    /// Constructs the original URL without any variant.
    var originalUrl: String {
        return "\(path).\(thumbnailExtension)"
    }
}

// MARK: - Creators
/// Represents the creators involved in a series.
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
/// Represents an individual creator in a series.
struct CreatorsItem: Codable {
    let resourceURI: String
    let name: String
    let role: String
}

// MARK: - Characters
/// Represents the characters involved in a series.
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharactersItem]
    let returned: Int
}

// MARK: - CharactersItem
/// Represents an individual character in a series.
struct CharactersItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
/// Represents the stories involved in a series.
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
/// Represents an individual story in a series.
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}
