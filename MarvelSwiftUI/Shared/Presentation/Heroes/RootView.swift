import SwiftUI

/// The root view of the app, responsible for managing the app's main content and state transitions.
struct RootView: View {
    /// The view model that handles the app's state and hero data.
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

// MARK: - Preview

#Preview {
    let vm = HeroListViewModel(useCase: HeroesUseCaseMock())
    RootView()
        .environment(vm)
}
