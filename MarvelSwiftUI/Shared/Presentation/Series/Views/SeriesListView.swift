import SwiftUI

struct SeriesListView: View {
    @State var viewModel: SeriesListViewModel
    let characterId: String
    
    init(characterId: String, viewmodel: SeriesListViewModel = SeriesListViewModel()) {
        self.characterId = characterId
        self.viewModel = viewmodel
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                SeriesLoadingView()
                    .transition(.opacity)
                    
            case .loaded:
                SeriesContentView(series: viewModel.series)
                    .transition(.opacity)
                    
            case .error(let message):
                SeriesErrorView(message: message)
                    .transition(.opacity)
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

/// Vista mostrada mientras se cargan las series
private struct SeriesLoadingView: View {
    var body: some View {
        LoadingView()
    }
}

/// Vista mostrada cuando ocurre un error al cargar las series
private struct SeriesErrorView: View {
    let message: String
    
    var body: some View {
        ErrorView(message: message)
    }
}

/// Vista mostrada cuando la lista de series está vacía
private struct SeriesEmptyView: View {
    var body: some View {
        Text("No series available for this hero.")
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
    }
}

/// Vista mostrada cuando las series se han cargado correctamente
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

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelMock = SeriesListViewModel(useCase: SeriesUseCaseMock())
        
        // Simular estado cargado con datos
        viewModelMock.state = .loaded
        viewModelMock.series = NetworkSeriesMock.mockSeries
        
        return SeriesListView(characterId: "0", viewmodel: viewModelMock)
    }
}
