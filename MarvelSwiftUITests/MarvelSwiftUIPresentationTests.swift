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
        
        @Test("Series Row Default View")
        @MainActor
        func seriesRowDefaultViewTest() throws {
            let view = SeriesRowDefault(series: Self.mockSeries)
            let inspected = try view.inspect()
            
            // Verificar título de la serie
            let title = try inspected.find(viewWithAccessibilityIdentifier: "SeriesTitle")
            #expect(try title.text().string() == Self.mockSeries.title, "El título de la serie no coincide")
            
            // Verificar imagen
            let image = try inspected.find(viewWithAccessibilityIdentifier: "ImageContainer")
            #expect(image != nil, "La imagen no se renderizó correctamente")
            
            // Verificar años
            let years = try inspected.find(viewWithAccessibilityIdentifier: "SeriesYears")
            #expect(try years.text().string().contains("\(Self.mockSeries.startYear)-\(Self.mockSeries.endYear)"), "Los años no coinciden")
            
            // Verificar rating
            if let rating = Self.mockSeries.rating, !rating.isEmpty, rating.lowercased() != "none" {
                let ratingView = try inspected.find(viewWithAccessibilityIdentifier: "SeriesRating")
                #expect(try ratingView.text().string() == rating, "El rating no coincide")
            }
            
            // Verificar cómics
            let comics = try inspected.find(viewWithAccessibilityIdentifier: "ComicsAvailable")
            let comicsText = try comics.text().string()
            #expect(comicsText.contains("\(Self.mockSeries.comics.available) Comics"), "El número de cómics no coincide")
            
            // Verificar eventos
            let events = try inspected.find(viewWithAccessibilityIdentifier: "EventsAvailable")
            let eventsText = try events.text().string()
            #expect(eventsText.contains("\(Self.mockSeries.events.available) Eventos"), "El número de eventos no coincide")
        }
        
        @Test("Series Row Compact View")
        @MainActor
        func seriesRowCompactViewTest() throws {
            let view = SeriesRowCompact(series: Self.mockSeries)
            let inspected = try view.inspect()
            
            // Verificar título de la serie
            let title = try inspected.find(viewWithAccessibilityIdentifier: "SeriesTitle")
            #expect(try title.text().string() == Self.mockSeries.title, "El título de la serie no coincide")
            
            // Verificar imagen
            let image = try inspected.find(viewWithAccessibilityIdentifier: "SeriesImage")
            #expect(image != nil, "La imagen no se renderizó correctamente")
            
            // Verificar cómics
            let comics = try inspected.find(viewWithAccessibilityIdentifier: "SeriesComicsAvailable")
            let comicsText = try comics.text().string()
            #expect(comicsText.contains("\(Self.mockSeries.comics.available) Comics"), "El número de cómics no coincide")
            
            // Verificar eventos
            let events = try inspected.find(viewWithAccessibilityIdentifier: "SeriesEventsAvailable")
            let eventsText = try events.text().string()
            #expect(eventsText.contains("\(Self.mockSeries.events.available) Eventos"), "El número de eventos no coincide")
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
