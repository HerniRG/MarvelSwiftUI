import Foundation

/// ViewModel for managing and fetching a list of series associated with a specific hero.
@Observable
final class SeriesListViewModel {
    /// List of series fetched for the hero.
    var series: [ResultSeries] = []
    
    /// Current state of the screen (e.g., loading, loaded, error).
    var state: StateScreen = .loading
    
    /// Use case for fetching series, ignored by SwiftUI's observation mechanism.
    @ObservationIgnored
    private var useCase: SeriesUseCaseProtocol

    /// Initializes the ViewModel with a series use case.
    /// - Parameter useCase: The use case for fetching series. Defaults to `SeriesUseCase()`.
    init(useCase: SeriesUseCaseProtocol = SeriesUseCase()) {
        self.useCase = useCase
    }

    /// Fetches the list of series for a specific hero.
    /// - Parameter characterId: The ID of the hero for whom the series are fetched.
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
