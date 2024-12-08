import Foundation
import Observation

@Observable
final class HeroListViewModel {
    var heroes: [ResultHero] = []
    var isLoading = false
    var errorMessage: String?

    private var totalHeroes = 0
    private let limit = 20
    private var currentOffset = 0
    private let useCase: HeroesUseCaseProtocol

    init(useCase: HeroesUseCaseProtocol = HeroesUseCase(repo: DefaultHeroesRepository())) {
        self.useCase = useCase
    }

    func fetchHeroes(reset: Bool = false) {
        guard !isLoading else { return }
        
        if reset {
            currentOffset = 0
            heroes = []
        }

        isLoading = true
        errorMessage = nil

        Task {
            let result = await useCase.getAllHeroes(offset: currentOffset, limit: limit)
            if let result = result {
                heroes.append(contentsOf: result.heroes)
                currentOffset += result.heroes.count
                totalHeroes = result.total
            } else {
                errorMessage = "No heroes found."
            }
            isLoading = false
        }
    }

    func fetchHeroesIfNeeded() {
        guard heroes.isEmpty else { return }
        fetchHeroes()
    }

    func loadMoreHeroes() {
        guard currentOffset < totalHeroes else { return }
        fetchHeroes()
    }
}
