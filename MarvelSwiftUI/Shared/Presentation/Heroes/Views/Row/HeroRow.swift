import SwiftUI

/// A view that represents a single row for displaying a hero's information.
/// Adapts its design based on the platform.
struct HeroRow: View {
    /// The hero to display in the row.
    let hero: ResultHero

    var body: some View {
        #if os(watchOS)
        HeroRowCompact(hero: hero) // Specific design for watchOS
        #else
        HeroRowDefault(hero: hero) // Design for other platforms
        #endif
    }
}

// MARK: - Previews
/// Preview provider for `HeroRow`.
struct HeroRow_Previews: PreviewProvider {
    /// A mock hero for preview purposes.
    static var mockHero: ResultHero {
        ResultHero(
            id: 1011334,
            name: "3-D Man",
            description: "A superhero with the power to view the world in three dimensions.",
            modified: Date(),
            thumbnail: ThumbnailHero(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                thumbnailExtension: .jpg
            ),
            resourceURI: "",
            comics: ComicsHero(available: 12, collectionURI: "", items: [], returned: 0),
            series: ComicsHero(available: 3, collectionURI: "", items: [], returned: 0),
            stories: StoriesHero(available: 5, collectionURI: "", items: [], returned: 0),
            events: ComicsHero(available: 1, collectionURI: "", items: [], returned: 0),
            urls: []
        )
    }
    
    static var previews: some View {
        #if os(watchOS)
        HeroRow(hero: mockHero)
            .previewLayout(.sizeThatFits)
        #else
        HeroRow(hero: mockHero)
            .previewLayout(.sizeThatFits)
            .padding()
        #endif
    }
}
