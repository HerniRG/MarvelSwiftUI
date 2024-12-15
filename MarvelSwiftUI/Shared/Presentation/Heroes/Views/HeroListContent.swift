import SwiftUI

struct HeroListContent: View {
    @Environment(HeroListViewModel.self) var viewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) { // Cambiado de LazyVStack a VStack
                    ForEach(viewModel.heroes, id: \.id) { hero in
                        NavigationLink(destination: SeriesListView(characterId: "\(hero.id)")) {
                            HeroRow(hero: hero)
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Marvel Heroes")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HeroListContent_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HeroListViewModel(useCase: HeroesUseCaseMock())
        
        return HeroListContent()
            .environment(vm)
    }
}
