import SwiftUI

struct HeroListContent: View {
    @Environment(HeroListViewModel.self) var viewModel
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.heroes, id: \.id) { hero in
                        HeroRow(hero: hero)
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Marvel Heroes")
            }
        }
        
    }
}

struct HeroListContent_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HeroListViewModel(useCase: HeroesUseCaseMock())
        
        return HeroListContent()
            .environment(vm)
    }
}
