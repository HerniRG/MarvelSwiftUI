import SwiftUI

/// A view that displays a list of Marvel heroes, adapting its layout for different platforms.
struct HeroListContent: View {
    /// The view model responsible for managing the list of heroes.
    @Environment(HeroListViewModel.self) var viewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Marvel Heroes")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    /// The main content view that adapts to the platform.
    @ViewBuilder
    private var content: some View {
        #if os(watchOS)
        // Use List for watchOS
        List(viewModel.heroes, id: \.id) { hero in
            NavigationLink(destination: SeriesListView(characterId: "\(hero.id)")) {
                HeroRow(hero: hero)
            }
            .listRowBackground(Color.clear)
        }
        #else
        // Use ScrollView for iOS
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

// MARK: - Preview

/// Preview provider for `HeroListContent`.
struct HeroListContent_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HeroListViewModel(useCase: HeroesUseCaseMock())
        
        return HeroListContent()
            .environment(vm)
    }
}
