import Foundation

@Observable
final class HeroListViewModel {
    var heroes: [ResultHero] = []
    var state: StateScreen = .loading
    
    @ObservationIgnored
    private let useCase: HeroesUseCaseProtocol
    
    init(useCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCase = useCase
        Task {
            await fetchHeroes()
        }
    }
    
    @MainActor
    func fetchHeroes() async {
        // Permitir que se reintente incluso si el estado es .error
        guard state == .loading || state == .error("No heroes found.") else { return }
        
        // Cambiar el estado a cargando para iniciar la operación
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
