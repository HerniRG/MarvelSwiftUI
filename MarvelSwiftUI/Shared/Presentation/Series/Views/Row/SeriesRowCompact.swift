import SwiftUI

/// A compact row view for displaying a series, optimized for smaller screens like watchOS.
struct SeriesRowCompact: View {
    /// The series to display in the row.
    let series: ResultSeries
    
    var body: some View {
        VStack(spacing: 8) {
            compactImageView
                .accessibilityIdentifier("SeriesImage")
            compactMetricsView
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(AppColors.cardBackground)
                .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColors.border, lineWidth: 0.3)
        )
    }
    
    // MARK: - Subviews
    
    /// A view displaying the series image.
    @ViewBuilder
    private var compactImageView: some View {
        AsyncImage(url: URL(string: "\(series.thumbnail.path).\(series.thumbnail.thumbnailExtension)")) { phase in
            switch phase {
            case .empty:
                ZStack {
                    AppColors.secondaryText.opacity(0.2)
                        .frame(height: 100)
                        .cornerRadius(10)
                    ProgressView()
                }
                .accessibilityIdentifier("ImageLoading")
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .clipped()
                    .cornerRadius(10)
                    .accessibilityIdentifier("SeriesImageSuccess")
            case .failure:
                AppColors.secondaryText.opacity(0.2)
                    .frame(height: 100)
                    .cornerRadius(10)
                    .accessibilityIdentifier("ImageError")
            @unknown default:
                AppColors.secondaryText.opacity(0.2)
                    .frame(height: 100)
                    .cornerRadius(10)
                    .accessibilityIdentifier("ImageError")
            }
        }
    }
    
    /// A view displaying the series title and associated metrics.
    @ViewBuilder
    private var compactMetricsView: some View {
        VStack(spacing: 4) {
            Text(series.title)
                .font(.caption2)
                .foregroundColor(AppColors.metricSeries)
                .accessibilityIdentifier("SeriesTitle")
            
            Text("\(series.comics.available) Comics")
                .font(.caption2)
                .foregroundColor(AppColors.metricComics)
                .accessibilityIdentifier("SeriesComicsAvailable")
            
            Text("\(series.events.available) Events")
                .font(.caption2)
                .foregroundColor(AppColors.metricEvents)
                .accessibilityIdentifier("SeriesEventsAvailable")
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
    }
}

// MARK: - Preview

/// Preview provider for `SeriesRowCompact`.
struct SeriesRowCompact_Previews: PreviewProvider {
    static var previews: some View {
        SeriesRowCompact(series: SeriesRow_Previews.mockSeries)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
