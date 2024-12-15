import Foundation

@Observable
final class SeriesListViewModel {
    var series: [ResultSeries] = [] // Datos observables
    var state: StateScreen = .loading // Estado de la pantalla
    
    @ObservationIgnored
    private var useCase: SeriesUseCaseProtocol // No observable

    // Inicializador
    init(useCase: SeriesUseCaseProtocol = SeriesUseCase()) {
        self.useCase = useCase
    }

    // Método para cargar las series
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
