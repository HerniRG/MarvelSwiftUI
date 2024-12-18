import SwiftUI

struct RootView: View {
    @Environment(HeroListViewModel.self) var viewModel
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                LoadingView()
                    .transition(CustomTransitions.loadingTransition())
                
            case .loaded:
                HeroListContent()
                    .transition(CustomTransitions.contentTransition())
                
            case .error(message: let message):
                ErrorView(message: message)
                    .transition(CustomTransitions.errorTransition())
            }
        }
        .animation(.easeInOut(duration: 0.6), value: viewModel.state)
    }
}

#Preview {
    let vm = HeroListViewModel(useCase: HeroesUseCaseMock())
    RootView()
        .environment(vm)
}

