import Foundation

/// ViewModel for managing and fetching a list of heroes.
@Observable
final class HeroListViewModel {
    /// List of heroes fetched from the Marvel API.
    var heroes: [ResultHero] = []
    
    /// Current state of the screen (e.g., loading, loaded, error).
    var state: StateScreen = .loading
    
    /// Use case for fetching heroes, ignored by SwiftUI's observation mechanism.
    @ObservationIgnored
    private let useCase: HeroesUseCaseProtocol
    
    /// Initializes the ViewModel with a heroes use case and triggers an initial fetch of heroes.
    /// - Parameter useCase: The use case for fetching heroes. Defaults to `HeroesUseCase()`.
    init(useCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCase = useCase
        Task {
            await fetchHeroes()
        }
    }
    
    /// Fetches the list of heroes from the use case.
    /// - Updates the `state` and `heroes` properties based on the result.
    @MainActor
    func fetchHeroes() async {
        // Allow retrying even if the state is `.error`
        guard state == .loading || state == .error("No heroes found.") else { return }
        
        // Set the state to loading before starting the operation
        state = .loading

        let result = await useCase.getAllHeroes()
        if let result = result {
            heroes = result
            state = .loaded
        } else {
            state = .error("No heroes found.")
        }
    }
}
