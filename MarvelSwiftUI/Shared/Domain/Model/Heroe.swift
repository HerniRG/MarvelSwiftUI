import Foundation

// MARK: - Heroe
/// Represents a Marvel hero response.
struct Heroe: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClassHero
}

// MARK: - DataClassHero
/// Contains the data for the hero response.
struct DataClassHero: Codable {
    let offset, limit, total, count: Int
    let results: [ResultHero]
}

// MARK: - ResultHero
/// Represents an individual Marvel hero.
struct ResultHero: Codable {
    let id: Int
    let name, description: String
    let modified: Date
    let thumbnail: ThumbnailHero
    let resourceURI: String
    let comics, series: ComicsHero
    let stories: StoriesHero
    let events: ComicsHero
    let urls: [URLElementHero]
}

// MARK: - ComicsHero
/// Represents the comics information for a hero.
struct ComicsHero: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItemHero]
    let returned: Int
}

// MARK: - ComicsItemHero
/// Represents an individual comic item.
struct ComicsItemHero: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - StoriesHero
/// Represents the stories information for a hero.
struct StoriesHero: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItemHero]
    let returned: Int
}

// MARK: - StoriesItemHero
/// Represents an individual story item.
struct StoriesItemHero: Codable {
    let resourceURI: String
    let name: String
    let type: ItemTypeHero
}

/// Types of story items.
enum ItemTypeHero: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case pinup = "pinup"
}

// MARK: - ThumbnailHero
/// Represents the thumbnail image for a hero.
struct ThumbnailHero: Codable {
    let path: String
    let thumbnailExtension: ExtensionHero

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

    /// Fixed format for horizontal images.
    private let defaultVariant = "landscape_amazing"

    /// Constructs the URL with a fixed image format.
    /// - Returns: A string representing the thumbnail URL.
    func url() -> String {
        return "\(path)/\(defaultVariant).\(thumbnailExtension.rawValue)"
    }
}

/// Represents the extension of the thumbnail image.
enum ExtensionHero: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

// MARK: - URLElementHero
/// Represents a URL element for a hero.
struct URLElementHero: Codable {
    let type: URLTypeHero
    let url: String
}

/// Types of URLs for a hero.
enum URLTypeHero: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
