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
        // Usar List para watchOS
        List(viewModel.heroes, id: \.id) { hero in
            NavigationLink(destination: SeriesListView(characterId: "\(hero.id)")) {
                HeroRow(hero: hero)
            }
            .listRowBackground(Color.clear)
        }
#else
        // Usar ScrollView para iOS
        ScrollView {
            VStack(spacing: 12) {
                ForEach(viewModel.heroes, id: \.id) { hero in
                    NavigationLink(destination: SeriesListView(characterId: "\(hero.id)")) {
                        HeroRow(hero: hero)
                    }
                }
            }
            .padding(.horizontal)
        }
#endif
    }
}

struct HeroListContent_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HeroListViewModel(useCase: HeroesUseCaseMock())
        
        return HeroListContent()
            .environment(vm)
    }
}
