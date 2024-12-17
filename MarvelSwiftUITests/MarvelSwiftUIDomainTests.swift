import Foundation
import Testing

@testable import MarvelSwiftUI

struct MarvelSwiftUIDomainTests {
    
    // MARK: - Suite para Testing del Dominio
    @Suite("Domain Testing") struct DomainTest {
        
        // MARK: - Modelos
        @Suite("Modelos", .serialized) struct ModelTest {
            
            // Datos mock reutilizables
            static let mockHero = ResultHero(
                id: 1011334,
                name: "3-D Man",
                description: "A superhero with the power to view the world in three dimensions.",
                modified: Date(),
                thumbnail: ThumbnailHero(
                    path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                    thumbnailExtension: .jpg
                ),
                resourceURI: "",
                comics: ComicsHero(available: 12, collectionURI: "", items: [], returned: 0),
                series: ComicsHero(available: 3, collectionURI: "", items: [], returned: 0),
                stories: StoriesHero(available: 5, collectionURI: "", items: [], returned: 0),
                events: ComicsHero(available: 1, collectionURI: "", items: [], returned: 0),
                urls: []
            )
            
            static let mockThumbnailHero = ThumbnailHero(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                thumbnailExtension: .jpg
            )
            
            static let mockSeries = ResultSeries(
                id: 2001,
                title: "Avengers Assemble",
                description: "The Earth's mightiest heroes.",
                resourceURI: "https://gateway.marvel.com/v1/public/series/2001",
                urls: [],
                startYear: 2012,
                endYear: 2014,
                rating: "PG-13",
                type: "comic",
                modified: Date(),
                thumbnail: Thumbnail(
                    path: "https://i.annihil.us/u/prod/marvel/i/mg/c/90/5f5699ab7a31b",
                    thumbnailExtension: "jpg"
                ),
                creators: Creators(available: 5, collectionURI: "", items: [], returned: 5),
                characters: Characters(available: 10, collectionURI: "", items: [], returned: 10),
                stories: Stories(available: 2, collectionURI: "", items: [], returned: 2),
                comics: Characters(available: 3, collectionURI: "", items: [], returned: 3),
                events: Characters(available: 1, collectionURI: "", items: [], returned: 1)
            )
            
            static let mockThumbnail = Thumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/c/90/5f5699ab7a31b",
                thumbnailExtension: "jpg"
            )
            
            @Test("Heroe Model")
            func modelHeroTest() async throws {
                let model = Self.mockHero
                #expect(model != nil)
                #expect(model.name == "3-D Man")
                #expect(model.comics.available == 12)
            }
            
            @Test("Heroe Thumbnail URL")
            func heroThumbnailURLTest() async throws {
                let thumbnail = Self.mockThumbnailHero
                #expect(thumbnail.url() == "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784/landscape_amazing.jpg")
            }
            
            @Test("Series Model")
            func modelSeriesTest() async throws {
                let series = Self.mockSeries
                #expect(series.title == "Avengers Assemble")
                #expect(series.startYear == 2012)
                #expect(series.thumbnail.path.contains("5f5699ab7a31b"))
            }
            
            @Test("Series Thumbnail URL")
            func seriesThumbnailURLTest() async throws {
                let thumbnail = Self.mockThumbnail
                let expectedURL = "https://i.annihil.us/u/prod/marvel/i/mg/c/90/5f5699ab7a31b/portrait_uncanny.jpg"
                #expect(thumbnail.verticalUrl == expectedURL, "La URL generada no coincide con el formato esperado")
            }
        }
        
        // MARK: - Casos de Uso
        @Suite("Casos de Uso", .serialized) struct UseCaseTest {
            
            @Test("Get All Heroes Use Case")
            func getAllHeroesUseCaseTest() async throws {
                let useCase = HeroesUseCaseMock()
                
                guard let heroes = await useCase.getAllHeroes() else {
                    fatalError("No se obtuvieron héroes del caso de uso")
                }
                
                #expect(heroes.count > 0, "La lista de héroes está vacía")
                #expect(heroes.first?.name == "Mock Hero 0", "El nombre del primer héroe no coincide")
            }
            
            @Test("Get Series Use Case")
            func getSeriesUseCaseTest() async throws {
                let useCase = NetworkSeriesMock()
                
                guard let series = await useCase.fetchHeroSeries(characterId: "1011334") else {
                    fatalError("No se obtuvieron series para el héroe")
                }
                
                #expect(series.count > 0, "La lista de series está vacía")
                #expect(series.first?.title == "Avengers Assemble", "El título de la primera serie no coincide")
            }
        }
    }
}
