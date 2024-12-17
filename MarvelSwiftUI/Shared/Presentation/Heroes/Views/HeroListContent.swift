import SwiftUI

struct HeroListContent: View {
    @Environment(HeroListViewModel.self) var viewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Marvel Heroes")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder
    private var content: some View {
#if os(watchOS)
        HeroListContentWatchView(heroes: viewModel.heroes)
#else
        HeroListContentiOSView(heroes: viewModel.heroes)
#endif
    }
}

// MARK: - Subviews

#if os(watchOS)
/// Vista específica para watchOS, usando una List
private struct HeroListContentWatchView: View {
    let heroes: [ResultHero]
    
    var body: some View {
        List(heroes, id: \.id) { hero in
            NavigationLink(destination: SeriesListView(characterId: "\(hero.id)")) {
                HeroRow(hero: hero)
            }
            .listRowBackground(Color.clear)
        }
    }
}
#else
/// Vista específica para iOS, usando ScrollView y VStack
private struct HeroListContentiOSView: View {
    let heroes: [ResultHero]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(heroes, id: \.id) { hero in
                    NavigationLink(destination: SeriesListView(characterId: "\(hero.id)")) {
                        HeroRow(hero: hero)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
#endif

// MARK: - Previews

struct HeroListContent_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HeroListViewModel(useCase: HeroesUseCaseMock())
        
        return HeroListContent()
            .environment(vm)
    }
}
