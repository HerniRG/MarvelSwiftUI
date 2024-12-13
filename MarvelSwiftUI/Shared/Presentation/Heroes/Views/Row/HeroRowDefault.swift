import SwiftUI

struct HeroRowDefault: View {
    let hero: ResultHero
    
    var body: some View {
        VStack(spacing: 0) {
            HeroRowImageHeader(hero: hero)
            HeroRowMetrics(hero: hero)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.background)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.9), lineWidth: 0.3)
        )
        .padding([.horizontal, .top])
    }
}

// MARK: - Subviews

private struct HeroRowImageHeader: View {
    let hero: ResultHero
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension.rawValue)")) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Color.gray.opacity(0.2)
                            .frame(height: 200)
                            .cornerRadius(10)
                        ProgressView()
                    }
                    .accessibilityIdentifier("ImageLoading")
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .accessibilityIdentifier("HeroImage")
                case .failure:
                    ZStack {
                        Color.gray.opacity(0.2)
                            .frame(height: 200)
                            .cornerRadius(10)
                        Text("Image not available")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("ImageErrorText")
                    }
                @unknown default:
                    Color.gray.frame(height: 200)
                        .cornerRadius(10)
                }
            }
            
            Text(hero.name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.7))
                .clipShape(Capsule())
                .padding(8)
                .accessibilityIdentifier("HeroName")
        }
    }
}

private struct HeroRowMetrics: View {
    let hero: ResultHero
    
    var body: some View {
        HStack {
            Label("\(hero.comics.available) Comics", systemImage: "book.fill")
                .font(.caption2)
                .foregroundColor(.blue)
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.blue.opacity(0.5), lineWidth: 0.5)
                        )
                )
                .accessibilityIdentifier("HeroComicsAvailable")
            Spacer()
            Label("\(hero.series.available) Series", systemImage: "film.fill")
                .font(.caption2)
                .foregroundColor(.green)
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.green.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.green.opacity(0.5), lineWidth: 0.5)
                        )
                )
                .accessibilityIdentifier("HeroSeriesAvailable")
        }
        .padding()
    }
}

// MARK: - Preview
struct HeroRowDefault_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowDefault(hero: ResultHero(
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
        ))
    }
}
