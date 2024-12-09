import SwiftUI

struct HeroRow: View {
    let hero: ResultHero
    @State private var animate = false // Controla la animación del placeholder
    
    var body: some View {
        NavigationLink(destination: SeriesListView(characterId: "\(hero.id)")) {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    // Imagen con degradado y sombra
                    AsyncImage(url: URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension.rawValue)")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                    } placeholder: {
                        PlaceholderView(animate: $animate) // Usamos el placeholder animado
                    }
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                    
                    // Nombre del héroe
                    Text(hero.name)
                        .font(.headline)
                        .foregroundStyle(LinearGradient(
                            gradient: Gradient(colors: [.red, .orange]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .padding(8)
                        .background(Color.black.opacity(0.8))
                        .clipShape(Capsule())
                        .padding(12)
                }
                
                // Información adicional
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Label("\(hero.comics.available) Comics", systemImage: "book.fill")
                            .foregroundColor(.blue)
                            .font(.caption)
                        Spacer()
                        Label("\(hero.series.available) Series", systemImage: "film.fill")
                            .foregroundColor(.green)
                            .font(.caption)
                    }
                }
                .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
            )
        }
    }
}

// MARK: - Preview
struct HeroRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeroRow(hero: ResultHero(
                id: 1011334,
                name: "3-D Man",
                description: "A classic Marvel character with unique powers.",
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
            ))
        }
        .padding()
    }
}
