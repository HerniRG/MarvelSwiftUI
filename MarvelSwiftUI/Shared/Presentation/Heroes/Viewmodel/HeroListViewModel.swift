import Foundation
import Observation

@Observable
final class HeroListViewModel {
    var heroes: [ResultHero] = []
    var state: StateHeroList = .loading
    private let useCase: HeroesUseCaseProtocol

    init(useCase: HeroesUseCaseProtocol = HeroesUseCase(repo: DefaultHeroesRepository())) {
        self.useCase = useCase
    }

    @MainActor
    func fetchHeroes() {
        guard state == .loading else { return }

        Task {
            let result = await useCase.getAllHeroes()
            if let result = result {
                heroes = result
                state = .loaded
            } else {
                state = .error("No heroes found.")
            }
        }
    }
}
