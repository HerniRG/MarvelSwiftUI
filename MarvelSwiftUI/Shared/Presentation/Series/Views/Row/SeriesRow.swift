import SwiftUI

struct SeriesRow: View {
    let series: ResultSeries

    var body: some View {
        VStack(spacing: 0) {
            SeriesRowHeaderView(series: series)
            SeriesRowMetricsView(series: series)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.background)
        )
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.9), lineWidth: 0.3)
        )
        .padding(.horizontal)
    }
}

// MARK: - Header View (Imagen + Título)
private struct SeriesRowHeaderView: View {
    let series: ResultSeries

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: "\(series.thumbnail.path).\(series.thumbnail.thumbnailExtension)")) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Color.gray.opacity(0.2)
                            .frame(height: 250)
                            .cornerRadius(10)
                            .accessibilityIdentifier("ImageLoading")
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(10)
                        .accessibilityIdentifier("ImageLoaded")
                case .failure:
                    ZStack {
                        Color.gray.opacity(0.2)
                            .frame(height: 250)
                            .cornerRadius(10)
                        Text("Imagen no disponible")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("ImageFailed")
                    }
                @unknown default:
                    Color.gray.opacity(0.2)
                        .frame(height: 250)
                        .cornerRadius(10)
                }
            }
            .accessibilityIdentifier("ImageContainer")

            Text(series.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.7))
                .clipShape(Capsule())
                .padding(8)
                .accessibilityIdentifier("SeriesTitle")
        }
        .frame(height: 250)
    }
}

// MARK: - Métricas View (Años, Rating, Comics, Eventos)
private struct SeriesRowMetricsView: View {
    let series: ResultSeries

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(series.startYear)-\(series.endYear)")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .accessibilityIdentifier("SeriesYears")

                Spacer()

                if let rating = series.rating, !rating.isEmpty, rating.lowercased() != "none" {
                    Text(rating)
                        .font(.caption)
                        .foregroundColor(.yellow)
                        .accessibilityIdentifier("SeriesRating")
                }
            }

            HStack {
                Text("\(series.comics.available) Comics")
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
                    .accessibilityIdentifier("ComicsAvailable")

                Spacer()

                Text("\(series.events.available) Eventos")
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
                    .accessibilityIdentifier("EventsAvailable")
            }
        }
        .padding()
        .accessibilityIdentifier("MetricsContainer")
    }
}

// MARK: - Preview
struct SeriesRow_Previews: PreviewProvider {
    static var previews: some View {
        SeriesRow(series: ResultSeries(
            id: 12345,
            title: "Amazing Spider-Man",
            description: "La historia clásica de Spider-Man desde sus inicios.",
            resourceURI: "http://gateway.marvel.com/v1/public/series/12345",
            urls: [],
            startYear: 2000,
            endYear: 2005,
            rating: "PG",
            type: "ongoing",
            modified: Date(),
            thumbnail: Thumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/c/90/515f04502b7e9", thumbnailExtension: "jpg"),
            creators: Creators(available: 10, collectionURI: "", items: [], returned: 0),
            characters: Characters(available: 3, collectionURI: "", items: [], returned: 0),
            stories: Stories(available: 5, collectionURI: "", items: [], returned: 0),
            comics: Characters(available: 50, collectionURI: "", items: [], returned: 0),
            events: Characters(available: 8, collectionURI: "", items: [], returned: 0)
        ))
        .padding()
    }
}
