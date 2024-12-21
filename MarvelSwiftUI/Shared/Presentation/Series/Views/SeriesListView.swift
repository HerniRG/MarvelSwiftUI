import SwiftUI

/// A view that displays a list of series for a specific hero, handling loading, error, and empty states.
struct SeriesListView: View {
    @State var viewModel: SeriesListViewModel
    let characterId: String
    
    /// Initializes the view with a specific character ID and optional view model.
    /// - Parameters:
    ///   - characterId: The ID of the hero for whom the series are fetched.
    ///   - viewmodel: The view model to manage series data. Defaults to a new instance.
    init(characterId: String, viewmodel: SeriesListViewModel = SeriesListViewModel()) {
        self.characterId = characterId
        self.viewModel = viewmodel
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                SeriesLoadingView()
                    .transition(CustomTransitions.loadingTransition())
                    
            case .loaded:
                SeriesContentView(series: viewModel.series)
                    .transition(CustomTransitions.contentTransition())
                    
            case .error(let message):
                SeriesErrorView(message: message)
                    .transition(CustomTransitions.errorTransition())
            }
        }
        .animation(.easeInOut, value: viewModel.state)
        .navigationTitle("Hero Series")
        .onAppear {
            Task {
                await viewModel.fetchSeries(for: characterId)
            }
        }
    }
}

// MARK: - Subviews

/// A view displayed while the series are loading.
private struct SeriesLoadingView: View {
    var body: some View {
        LoadingView()
    }
}

/// A view displayed when an error occurs while loading the series.
private struct SeriesErrorView: View {
    let message: String
    
    var body: some View {
        ErrorView(message: message, series: true)
    }
}

/// A view displayed when no series are available for the hero.
private struct SeriesEmptyView: View {
    var body: some View {
        Text("No series available for this hero.")
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
    }
}

/// A view displayed when the series have been successfully loaded.
private struct SeriesContentView: View {
    let series: [ResultSeries]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if series.isEmpty {
                    SeriesEmptyView()
                } else {
                    ForEach(series, id: \.id) { serie in
                        SeriesRow(series: serie)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Preview

/// Preview provider for `SeriesListView`.
struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelMock = SeriesListViewModel(useCase: SeriesUseCaseMock())
        
        // Simulate the loaded state with mock data
        viewModelMock.state = .loaded
        viewModelMock.series = NetworkSeriesMock.mockSeries
        
        return SeriesListView(characterId: "0", viewmodel: viewModelMock)
    }
}
