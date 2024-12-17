import SwiftUI

struct SeriesRowCompact: View {
    let series: ResultSeries
    
    var body: some View {
        VStack(spacing: 8) {
            compactImageView
                .accessibilityIdentifier("SeriesImage") // Identificador para la imagen
            compactMetricsView
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white.opacity(0.1))
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.9), lineWidth: 0.3)
        )
    }
    
    @ViewBuilder
    private var compactImageView: some View {
        AsyncImage(url: URL(string: "\(series.thumbnail.path).\(series.thumbnail.thumbnailExtension)")) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color.gray
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
                    .cornerRadius(10)
            case .failure:
                Color.gray.frame(height: 100)
            @unknown default:
                Color.gray.frame(height: 100)
            }
        }
    }
    
    @ViewBuilder
    private var compactMetricsView: some View {
        VStack(spacing: 4) {
            Text(series.title)
                .font(.caption2)
                .foregroundColor(.orange)
                .accessibilityIdentifier("SeriesTitle")

            Text("\(series.comics.available) Comics")
                .font(.caption2)
                .foregroundColor(.blue)
                .accessibilityIdentifier("SeriesComicsAvailable")

            Text("\(series.events.available) Eventos")
                .font(.caption2)
                .foregroundColor(.green)
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
