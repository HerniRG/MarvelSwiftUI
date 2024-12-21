//
//  SeriesRowDefault.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 6/12/24.
//

import SwiftUI

/// A default row view for displaying a series, optimized for larger screens.
struct SeriesRowDefault: View {
    /// The series to display in the row.
    let series: ResultSeries

    var body: some View {
        VStack(spacing: 0) {
            SeriesRowHeaderView(series: series)
            SeriesRowMetricsView(series: series)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(AppColors.background)
        )
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(AppColors.border, lineWidth: 0.3)
        )
        .padding(.horizontal)
    }
}

// MARK: - Header View

/// A view displaying the series image and title.
private struct SeriesRowHeaderView: View {
    /// The series to display in the header.
    let series: ResultSeries

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: "\(series.thumbnail.path).\(series.thumbnail.thumbnailExtension)")) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        AppColors.secondaryText.opacity(0.2)
                            .frame(height: 250)
                            .cornerRadius(10)
                        ProgressView()
                    }
                    .accessibilityIdentifier("ImageLoading")
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
                        AppColors.secondaryText.opacity(0.2)
                            .frame(height: 250)
                            .cornerRadius(10)
                        Text("Image not available")
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText)
                            .accessibilityIdentifier("ImageFailed")
                    }
                @unknown default:
                    AppColors.secondaryText.opacity(0.2)
                        .frame(height: 250)
                        .cornerRadius(10)
                }
            }
            .accessibilityIdentifier("ImageContainer")

            Text(series.title)
                .font(.headline)
                .foregroundColor(AppColors.heroName)
                .padding(8)
                .background(AppColors.overlayDark)
                .clipShape(Capsule())
                .padding(8)
                .accessibilityIdentifier("SeriesTitle")
        }
        .frame(height: 250)
    }
}

// MARK: - Metrics View

/// A view displaying the series metrics such as years, rating, comics, and events.
private struct SeriesRowMetricsView: View {
    /// The series whose metrics are displayed.
    let series: ResultSeries

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(series.startYear)-\(series.endYear)")
                    .font(.caption)
                    .foregroundColor(AppColors.metricEvents)
                    .accessibilityIdentifier("SeriesYears")

                Spacer()

                if let rating = series.rating, !rating.isEmpty, rating.lowercased() != "none" {
                    Text(rating)
                        .font(.caption)
                        .foregroundColor(AppColors.warning)
                        .accessibilityIdentifier("SeriesRating")
                }
            }

            HStack {
                Text("\(series.comics.available) Comics")
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
                    .accessibilityIdentifier("ComicsAvailable")

                Spacer()

                Text("\(series.events.available) Events")
                    .font(.caption2)
                    .foregroundColor(AppColors.metricEvents)
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(AppColors.metricEvents.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(AppColors.metricEvents.opacity(0.5), lineWidth: 0.5)
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

/// Preview provider for `SeriesRowDefault`.
struct SeriesRowDefault_Previews: PreviewProvider {
    static var previews: some View {
        SeriesRowDefault(series: SeriesRow_Previews.mockSeries)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
