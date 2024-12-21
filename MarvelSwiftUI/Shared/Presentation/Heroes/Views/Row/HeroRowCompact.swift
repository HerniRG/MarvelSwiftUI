import SwiftUI

/// A compact row view for displaying hero information, optimized for smaller screens like watchOS.
struct HeroRowCompact: View {
    /// The hero to display in the row.
    let hero: ResultHero
    
    var body: some View {
        VStack(spacing: 8) {
            HeroRowCompactImage(hero: hero)
            HeroRowCompactMetrics(hero: hero)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(AppColors.cardBackground)
                .shadow(color: AppColors.overlayDark, radius: 10, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColors.overlayDark.opacity(0.9), lineWidth: 0.3)
        )
    }
}

// MARK: - Subviews

/// Displays the hero's image and name in the compact row.
private struct HeroRowCompactImage: View {
    /// The hero whose image and name are displayed.
    let hero: ResultHero
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension.rawValue)")) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        AppColors.overlayDark
                            .opacity(0.3)
                            .frame(height: 100)
                            .cornerRadius(10)
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)
                        .clipped()
                        .transition(.opacity)
                        .accessibilityIdentifier("HeroImage")
                case .failure:
                    AppColors.error.opacity(0.3)
                        .frame(height: 100)
                @unknown default:
                    AppColors.text.opacity(0.3)
                        .frame(height: 100)
                }
            }
            .cornerRadius(10)
            
            Text(hero.name)
                .font(.headline)
                .foregroundColor(AppColors.heroName)
                .padding(8)
                .background(AppColors.overlayDark)
                .clipShape(Capsule())
                .padding(8)
                .accessibilityIdentifier("HeroName")
        }
    }
}

/// Displays the hero's metrics (e.g., available comics and series) in the compact row.
private struct HeroRowCompactMetrics: View {
    /// The hero whose metrics are displayed.
    let hero: ResultHero
    
    var body: some View {
        Label("\(hero.comics.available) Comics", systemImage: "book.fill")
            .font(.caption)
            .foregroundColor(AppColors.metricComics)
            .padding(4)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(AppColors.metricComics.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(AppColors.metricComics.opacity(0.5), lineWidth: 0.5)
                    )
            )
            .accessibilityIdentifier("HeroComicsAvailable")
        
        Label("\(hero.series.available) Series", systemImage: "film.fill")
            .font(.caption)
            .foregroundColor(AppColors.metricSeries)
            .padding(4)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(AppColors.metricSeries.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(AppColors.metricSeries.opacity(0.5), lineWidth: 0.5)
                    )
            )
            .accessibilityIdentifier("HeroSeriesAvailable")
    }
}

// MARK: - Preview

/// Preview provider for `HeroRowCompact`.
struct HeroRowCompact_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowCompact(hero: ResultHero(
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
        .previewLayout(.sizeThatFits)
    }
}
