import Foundation

// MARK: - Heroe
struct Heroe: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClassHero
}

// MARK: - DataClassHero
struct DataClassHero: Codable {
    let offset, limit, total, count: Int
    let results: [ResultHero]
}

// MARK: - ResultHero
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
struct ComicsHero: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItemHero]
    let returned: Int
}

// MARK: - ComicsItemHero
struct ComicsItemHero: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - StoriesHero
struct StoriesHero: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItemHero]
    let returned: Int
}

// MARK: - StoriesItemHero
struct StoriesItemHero: Codable {
    let resourceURI: String
    let name: String
    let type: ItemTypeHero
}

enum ItemTypeHero: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case pinup = "pinup"
}

// MARK: - ThumbnailHero
struct ThumbnailHero: Codable {
    let path: String
    let thumbnailExtension: ExtensionHero

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

    // Formato fijo para imágenes horizontales
    private let defaultVariant = "landscape_amazing"

    // Método para obtener la URL con formato fijo
    func url() -> String {
        return "\(path)/\(defaultVariant).\(thumbnailExtension.rawValue)"
    }
}

enum ExtensionHero: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

// MARK: - URLElementHero
struct URLElementHero: Codable {
    let type: URLTypeHero
    let url: String
}

enum URLTypeHero: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
