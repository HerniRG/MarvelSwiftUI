import SwiftUI

struct HeroListContent: View {
    @Environment(HeroListViewModel.self) var viewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.heroes, id: \.id) { hero in
                    HeroRow(hero: hero)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct HeroListContent_Previews: PreviewProvider {
    static var previews: some View {
        HeroListContent()
            .environment(HeroListViewModel())
    }
}
