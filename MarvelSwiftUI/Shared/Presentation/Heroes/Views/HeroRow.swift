import SwiftUI

// MARK: - HeroRow
struct HeroRow: View {
    let hero: ResultHero
    
    var body: some View {
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
                                gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                }
                .cornerRadius(12)

                // Nombre del héroe sobre la imagen
                Text(hero.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Capsule())
                    .padding(12)
            }
            
            // Descripción e información adicional
            VStack(alignment: .leading, spacing: 8) {
                if !hero.description.isEmpty {
                    Text(hero.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                }

                HStack {
                    HStack {
                        Image(systemName: "book")
                            .foregroundColor(.blue)
                        Text("\(hero.comics.available) Comics")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "film")
                            .foregroundColor(.green)
                        Text("\(hero.series.available) Series")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
        )
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
