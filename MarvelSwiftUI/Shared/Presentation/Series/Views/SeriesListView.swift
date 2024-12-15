import SwiftUI

struct SeriesListView: View {
    @State var viewModel: SeriesListViewModel
    let characterId: String
    
    init(characterId: String, viewmodel: SeriesListViewModel = SeriesListViewModel()) {
        self.characterId = characterId
        self.viewModel = viewmodel
    }
    
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                case .loaded:
                    ScrollView {
                        if viewModel.series.count == 0 {
                            Text("No series available for this hero.")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            LazyVStack(spacing: 20) {
                                ForEach(viewModel.series, id: \.id) { serie in
                                    SeriesRow(series: serie)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .navigationTitle("Hero Series")
                case .error(let message):
                    ErrorView(message: message)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchSeries(for: characterId)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelMock = SeriesListViewModel(useCase: SeriesUseCaseMock())
        
        SeriesListView(characterId: "0", viewmodel: viewModelMock)
    }
}
