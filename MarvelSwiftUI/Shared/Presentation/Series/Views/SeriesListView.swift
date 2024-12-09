import SwiftUI

struct SeriesListView: View {
    @State private var viewModel = SeriesListViewModel() // Usando @State
    let characterId: String

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Hero Series")
                .onAppear {
                    if viewModel.series.isEmpty {
                        viewModel.fetchSeries(for: characterId)
                    }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.series.isEmpty {
            ProgressView("Loading Series...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
        } else if let error = viewModel.errorMessage {
            ErrorView(message: error)
        } else if viewModel.series.isEmpty {
            Text("No series found for this hero.")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
        } else {
            SeriesList(series: viewModel.series)
        }
    }
}

struct SeriesList: View {
    let series: [Result]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(series, id: \.id) { serie in
                    SeriesRowView(series: serie)
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - SeriesRowView
struct SeriesRowView: View {
    let series: Result

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "\(series.thumbnail.path).\(series.thumbnail.thumbnailExtension)")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            } placeholder: {
                Color.gray.frame(width: 50, height: 50)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(series.title)
                    .font(.headline)
                if let description = series.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 3)
    }
}

// MARK: - Preview
struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListView(characterId: "1011297") // Ejemplo con un ID de héroe
            .previewDevice("iPhone 14")
    }
}
