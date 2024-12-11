import Foundation
import Observation

@Observable
final class HeroListViewModel {
    var heroes: [ResultHero] = []
    var state: StateHeroList = .loading
    private let useCase: HeroesUseCaseProtocol
    
    init(useCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCase = useCase
        Task {
            await fetchHeroes()
        }
    }
    
    @MainActor
    func fetchHeroes() async {
        guard state == .loading else { return }
        
        let result = await useCase.getAllHeroes()
        if let result = result {
            heroes = result
            state = .loaded
        } else {
            state = .error("No heroes found.")
        }
        
    }
}
