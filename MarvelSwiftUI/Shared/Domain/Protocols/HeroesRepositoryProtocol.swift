import Foundation

/// Protocolo para manejar las solicitudes relacionadas con los héroes
protocol HeroesRepositoryProtocol {
    /// Obtiene todos los héroes disponibles desde la API de Marvel
    /// - Returns: Una lista de héroes obtenidos o `nil` si ocurre un error.
    func getAllHeroes() async -> [ResultHero]?
}
