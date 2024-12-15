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
                LoadingView()
                    .transition(.opacity) // Suaviza la transición
            case .loaded:
                ScrollView {
                    VStack(spacing: 20) { // Cambiado de LazyVStack a VStack
                        if viewModel.series.isEmpty {
                            Text("No series available for this hero.")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(viewModel.series, id: \.id) { serie in
                                SeriesRow(series: serie)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .transition(.opacity)
            case .error(let message):
                ErrorView(message: message)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: viewModel.state) // Aplica animación al cambiar de estado
        .navigationTitle("Hero Series") // Título consistente para todas las pantallas
        .onAppear {
            Task {
                await viewModel.fetchSeries(for: characterId)
            }
        }
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelMock = SeriesListViewModel(useCase: SeriesUseCaseMock())
        
        SeriesListView(characterId: "0", viewmodel: viewModelMock)
    }
}
