import SwiftUI

struct SeriesRowDefault: View {
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
struct SeriesRowDefault_Previews: PreviewProvider {
    static var previews: some View {
        SeriesRowDefault(series: SeriesRow_Previews.mockSeries)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
