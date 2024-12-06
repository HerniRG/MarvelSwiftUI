import Foundation
import Observation

@Observable
final class HeroListViewModel {
    // MARK: - Properties
    var heroes: [ResultHero] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var totalHeroes: Int = 0

    private let limit: Int = 20
    private var currentOffset: Int = 0
    private let useCase: HeroesUseCaseProtocol

    // MARK: - Initializer
    init(useCase: HeroesUseCaseProtocol = HeroesUseCase(repo: DefaultHeroesRepository())) {
        self.useCase = useCase
    }

    // MARK: - Methods
    @MainActor
    func fetchHeroes(reset: Bool = false) {
        // Si es un reset, reinicia el estado
        if reset {
            currentOffset = 0
            heroes.removeAll()
        }

        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        Task {
            do {
                if let result = await useCase.getAllHeroes(offset: currentOffset, limit: limit) {
                    // Actualizar los datos en el hilo principal
                    heroes.append(contentsOf: result.heroes)
                    currentOffset += result.heroes.count
                    totalHeroes = result.total
                } else {
                    errorMessage = "No heroes found."
                }
            }
            isLoading = false
        }
    }
    
    @MainActor
    func loadMoreHeroes() {
        guard currentOffset < totalHeroes else { return }
        fetchHeroes()
    }
}
