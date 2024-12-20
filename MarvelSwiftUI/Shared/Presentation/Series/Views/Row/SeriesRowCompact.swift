import SwiftUI

struct SeriesRowCompact: View {
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
            @unknown default:
                AppColors.secondaryText.opacity(0.2)
                    .frame(height: 100)
                    .cornerRadius(10)
            }
        }
    }
    
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
            
            Text("\(series.events.available) Eventos")
                .font(.caption2)
                .foregroundColor(AppColors.metricEvents)
                .accessibilityIdentifier("SeriesEventsAvailable")
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
    }
}

// MARK: - Preview
struct SeriesRowCompact_Previews: PreviewProvider {
    static var previews: some View {
        SeriesRowCompact(series: SeriesRow_Previews.mockSeries)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
