import SwiftUI

/// A view that displays a row for a series, adapting its layout for different platforms.
struct SeriesRow: View {
    /// The series to display in the row.
    let series: ResultSeries

    var body: some View {
        #if os(watchOS)
        SeriesRowCompact(series: series) // Compact layout for watchOS
        #else
        SeriesRowDefault(series: series) // Default layout for other platforms
        #endif
    }
}

// MARK: - Previews

/// Preview provider for `SeriesRow`.
struct SeriesRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            #if os(watchOS)
            SeriesRow(series: mockSeries)
                .previewLayout(.sizeThatFits)
            #else
            SeriesRow(series: mockSeries)
                .previewLayout(.sizeThatFits)
                .padding()
            #endif
        }
    }

    /// A mock series for preview purposes.
    static var mockSeries: ResultSeries {
        ResultSeries(
            id: 12345,
            title: "Amazing Spider-Man",
            description: "The classic story of Spider-Man from the beginning.",
            resourceURI: "http://gateway.marvel.com/v1/public/series/12345",
            urls: [],
            startYear: 2000,
            endYear: 2005,
            rating: "PG",
            type: "ongoing",
            modified: Date(),
            thumbnail: Thumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/c/90/515f04502b7e9",
                thumbnailExtension: "jpg"
            ),
            creators: Creators(available: 10, collectionURI: "", items: [], returned: 0),
            characters: Characters(available: 3, collectionURI: "", items: [], returned: 0),
            stories: Stories(available: 5, collectionURI: "", items: [], returned: 0),
            comics: Characters(available: 50, collectionURI: "", items: [], returned: 0),
            events: Characters(available: 8, collectionURI: "", items: [], returned: 0)
        )
    }
}
