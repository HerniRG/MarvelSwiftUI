import Foundation
import SwiftUI
import Testing
import ViewInspector

@testable import MarvelSwiftUI

struct MarvelSwiftUIPresentationTests {
    
    @Suite("Presentation Testing") struct PresentationTest {
        
        // MARK: - Mock Data
        static let mockSeries = ResultSeries(
            id: 12345,
            title: "Amazing Spider-Man",
            description: "La historia clásica de Spider-Man desde sus inicios.",
            resourceURI: "http://gateway.marvel.com/v1/public/series/12345",
            urls: [],
            startYear: 2000,
            endYear: 2005,
            rating: "PG",
            type: "ongoing",
            modified: Date(),
            thumbnail: Thumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/c/90/515f04502b7e9",
                thumbnailExtension: "jpg"
            ),
            creators: Creators(available: 10, collectionURI: "", items: [], returned: 0),
            characters: Characters(available: 3, collectionURI: "", items: [], returned: 0),
            stories: Stories(available: 5, collectionURI: "", items: [], returned: 0),
            comics: Characters(available: 50, collectionURI: "", items: [], returned: 0),
            events: Characters(available: 8, collectionURI: "", items: [], returned: 0)
        )
        
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
        
        // MARK: - Tests
        
        @Test("Series Row View")
        @MainActor
        func seriesRowViewTest() throws {
            let view = SeriesRow(series: Self.mockSeries)
            let inspected = try view.inspect()
            
            // Verificamos el título
            let title = try inspected.find(viewWithAccessibilityIdentifier: "SeriesTitle")
            #expect(try title.text().string() == Self.mockSeries.title, "El título no coincide")
            
            // Verificamos los años
            let years = try inspected.find(viewWithAccessibilityIdentifier: "SeriesYears")
            #expect(try years.text().string() == "\(Self.mockSeries.startYear)-\(Self.mockSeries.endYear)", "Los años no coinciden")
            
            // Verificamos la disponibilidad de comics
            let comics = try inspected.find(viewWithAccessibilityIdentifier: "ComicsAvailable")
            #expect(try comics.text().string().contains("\(Self.mockSeries.comics.available) Comics"), "Los comics no coinciden")
            
            // Verificamos la disponibilidad de eventos
            let events = try inspected.find(viewWithAccessibilityIdentifier: "EventsAvailable")
            #expect(try events.text().string().contains("\(Self.mockSeries.events.available) Eventos"), "Los eventos no coinciden")
        }
        
        @Test("Hero Row Default View")
        @MainActor
        func heroRowDefaultViewTest() throws {
            let view = HeroRowDefault(hero: Self.mockHero)
            let inspected = try view.inspect()
            
            // Verificar nombre del héroe
            let nameText = try inspected.find(viewWithAccessibilityIdentifier: "HeroName")
            #expect(try nameText.text().string() == Self.mockHero.name, "El nombre del héroe no coincide")
            
            // Verificar imagen del héroe
            let image = try inspected.find(viewWithAccessibilityIdentifier: "HeroImage")
            #expect(image != nil, "La imagen no se renderizó correctamente")
            
            // Verificar métrica de cómics en el Label
            let comicsLabel = try inspected.find(viewWithAccessibilityIdentifier: "HeroComicsAvailable").label()
            let comicsTitle = try comicsLabel.title().text().string()
            #expect(comicsTitle.contains("\(Self.mockHero.comics.available) Comics"), "El número de cómics no coincide")
            
            // Verificar métrica de series en el Label
            let seriesLabel = try inspected.find(viewWithAccessibilityIdentifier: "HeroSeriesAvailable").label()
            let seriesTitle = try seriesLabel.title().text().string()
            #expect(seriesTitle.contains("\(Self.mockHero.series.available) Series"), "El número de series no coincide")
        }
        
        @Test("Hero Row Compact View")
        @MainActor
        func heroRowCompactViewTest() throws {
            let view = HeroRowCompact(hero: Self.mockHero)
            let inspected = try view.inspect()
            
            // Verificar nombre del héroe
            let nameText = try inspected.find(viewWithAccessibilityIdentifier: "HeroName")
            #expect(try nameText.text().string() == Self.mockHero.name, "El nombre del héroe no coincide")
            
            // Verificar imagen del héroe
            let image = try inspected.find(viewWithAccessibilityIdentifier: "HeroImage")
            #expect(image != nil, "La imagen no se renderizó correctamente")
            
            // Verificar métrica de cómics en el Label
            let comicsLabel = try inspected.find(viewWithAccessibilityIdentifier: "HeroComicsAvailable").label()
            let comicsTitle = try comicsLabel.title().text().string()
            #expect(comicsTitle.contains("\(Self.mockHero.comics.available) Comics"), "El número de cómics no coincide")
            
            // Verificar métrica de series en el Label
            let seriesLabel = try inspected.find(viewWithAccessibilityIdentifier: "HeroSeriesAvailable").label()
            let seriesTitle = try seriesLabel.title().text().string()
            #expect(seriesTitle.contains("\(Self.mockHero.series.available) Series"), "El número de series no coincide")
        }
    }
}
