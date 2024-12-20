import Foundation

@Observable
final class SeriesListViewModel {
    var series: [ResultSeries] = []
    var state: StateScreen = .loading
    
    @ObservationIgnored
    private var useCase: SeriesUseCaseProtocol

    init(useCase: SeriesUseCaseProtocol = SeriesUseCase()) {
        self.useCase = useCase
    }

    @MainActor
    func fetchSeries(for characterId: String) async {
        guard state == .loading else { return }
        
        let result = await useCase.getHeroSeries(characterId: characterId)
        
        if let result = result {
            series = result
            state = .loaded
        } else {
            state = .error("Failed to load series for this hero.")
        }
    }
}
