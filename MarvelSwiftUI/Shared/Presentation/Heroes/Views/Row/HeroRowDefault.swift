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
                .fill(AppColors.background)
                .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 4) // Usando AppColors.shadow
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColors.border, lineWidth: 0.3) // Usando AppColors.border
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
                        AppColors.secondaryText.opacity(0.2) // Placeholder más sutil
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
                        AppColors.error.opacity(0.3) // Indicador de error más claro
                            .frame(height: 200)
                            .cornerRadius(10)
                        Text("Image not available")
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText)
                            .accessibilityIdentifier("ImageErrorText")
                    }
                @unknown default:
                    ZStack {
                        AppColors.secondaryText.opacity(0.2)
                            .frame(height: 200)
                            .cornerRadius(10)
                        Text("Image not available")
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText)
                            .accessibilityIdentifier("ImageErrorText")
                    }
                }
            }
            
            Text(hero.name)
                .font(.headline)
                .foregroundColor(AppColors.heroName) // Usando AppColors.heroName
                .padding(8)
                .background(AppColors.overlayDark)
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
            Spacer()
            Label("\(hero.series.available) Series", systemImage: "film.fill")
                .font(.caption2)
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
        .padding() // Ajuste para mayor claridad
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
