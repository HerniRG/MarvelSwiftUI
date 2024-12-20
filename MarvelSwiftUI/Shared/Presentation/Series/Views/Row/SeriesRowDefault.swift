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
                .fill(AppColors.background) // Reemplazado con AppColors.background
        )
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 4) // Usando AppColors.shadow
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColors.border, lineWidth: 0.3) // Usando AppColors.border
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
                        AppColors.secondaryText.opacity(0.2) // Reemplazado con AppColors.secondaryText.opacity(0.2)
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
                        AppColors.secondaryText.opacity(0.2) // Reemplazado con AppColors.secondaryText.opacity(0.2)
                            .frame(height: 250)
                            .cornerRadius(10)
                        Text("Imagen no disponible")
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText) // Reemplazado con AppColors.secondaryText
                            .accessibilityIdentifier("ImageFailed")
                    }
                @unknown default:
                    AppColors.secondaryText.opacity(0.2) // Reemplazado con AppColors.secondaryText.opacity(0.2)
                        .frame(height: 250)
                        .cornerRadius(10)
                }
            }
            .accessibilityIdentifier("ImageContainer")

            Text(series.title)
                .font(.headline)
                .foregroundColor(AppColors.heroName) // Reemplazado con AppColors.heroName
                .padding(8)
                .background(AppColors.overlayDark) // Reemplazado con AppColors.overlayDark
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
                    .foregroundColor(AppColors.metricEvents) // Reemplazado con AppColors.metricEvents
                    .accessibilityIdentifier("SeriesYears")

                Spacer()

                if let rating = series.rating, !rating.isEmpty, rating.lowercased() != "none" {
                    Text(rating)
                        .font(.caption)
                        .foregroundColor(AppColors.warning) // Reemplazado con AppColors.warning
                        .accessibilityIdentifier("SeriesRating")
                }
            }

            HStack {
                Text("\(series.comics.available) Comics")
                    .font(.caption2)
                    .foregroundColor(AppColors.metricComics) // Reemplazado con AppColors.metricComics
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(AppColors.metricComics.opacity(0.1)) // Reemplazado con AppColors.metricComics.opacity(0.1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(AppColors.metricComics.opacity(0.5), lineWidth: 0.5) // Reemplazado con AppColors.metricComics.opacity(0.5)
                            )
                    )
                    .accessibilityIdentifier("ComicsAvailable")

                Spacer()

                Text("\(series.events.available) Eventos")
                    .font(.caption2)
                    .foregroundColor(AppColors.metricEvents) // Reemplazado con AppColors.metricEvents
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(AppColors.metricEvents.opacity(0.1)) // Reemplazado con AppColors.metricEvents.opacity(0.1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(AppColors.metricEvents.opacity(0.5), lineWidth: 0.5) // Reemplazado con AppColors.metricEvents.opacity(0.5)
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
