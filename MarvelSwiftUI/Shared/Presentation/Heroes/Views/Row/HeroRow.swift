import SwiftUI

struct HeroRow: View {
    let hero: ResultHero

    var body: some View {
#if os(watchOS)
        HeroRowCompact(hero: hero) // Diseño específico para watchOS
#else
        HeroRowDefault(hero: hero) // Diseño para todas las demás plataformas
#endif
    }
}

// MARK: - Previews
struct HeroRow_Previews: PreviewProvider {
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
