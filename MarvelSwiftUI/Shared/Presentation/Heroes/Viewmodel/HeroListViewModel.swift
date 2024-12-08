import Foundation
import Observation

@Observable
final class HeroListViewModel {
    var heroes: [ResultHero] = []
    var state: StateHeroList = .loading

    private var totalHeroes = 0
    private let limit = 20
    private var currentOffset = 0
    private let useCase: HeroesUseCaseProtocol

    init(useCase: HeroesUseCaseProtocol = HeroesUseCase(repo: DefaultHeroesRepository())) {
        self.useCase = useCase
    }
    
    @MainActor
    func fetchHeroes(reset: Bool = false) {
        guard case .loading = state else { return }
        
        if reset {
            currentOffset = 0
            heroes = []
        }

        state = .loading

        Task {
            let result = await useCase.getAllHeroes(offset: currentOffset, limit: limit)
            if let result = result {
                heroes.append(contentsOf: result.heroes)
                currentOffset += result.heroes.count
                totalHeroes = result.total
                state = .loaded
            } else {
                state = .error("No heroes found.")
            }
        }
    }
    
    @MainActor
    func fetchHeroesIfNeeded() {
        guard heroes.isEmpty else { return }
        fetchHeroes()
    }
    
    @MainActor
    func loadMoreHeroes() {
        guard currentOffset < totalHeroes else { return }
        fetchHeroes()
    }
}
