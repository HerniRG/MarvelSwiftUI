import Foundation
import Combine

@Observable
final class SeriesListViewModel {
    var series: [Result] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let useCase: SeriesUseCaseProtocol

    init(useCase: SeriesUseCaseProtocol = SeriesUseCase()) {
        self.useCase = useCase
    }

    @MainActor
    func fetchSeries(for characterId: String) {
        guard !isLoading else { return } // Evita múltiples cargas simultáneas
        isLoading = true
        errorMessage = nil

        Task {
            do {
                if let response = await useCase.getHeroSeries(characterId: characterId) {
                    if response.isEmpty {
                        errorMessage = "No series found for this hero."
                        NSLog("Error: La lista de series está vacía.")
                    } else {
                        series = response
                    }
                } else {
                    errorMessage = "Failed to load series: Response is nil."
                    NSLog("Error: El caso de uso devolvió nil.")
                }
            }
            isLoading = false
        }
    }
}
