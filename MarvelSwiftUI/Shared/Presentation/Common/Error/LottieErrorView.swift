import SwiftUI
#if !os(watchOS)
import Lottie
#endif

#if !os(watchOS)
/// A view that displays an error message with an animation and an optional retry button.
struct LottieErrorView: View {
    /// The view model handling the hero list logic.
    @Environment(HeroListViewModel.self) var viewModel
    
    /// The error message to display.
    let message: String
    
    /// Indicates if the error view is called from the series screen.
    let series: Bool
    
    var body: some View {
        VStack {
            if let path = Bundle.main.path(forResource: "error", ofType: "json") {
                LottieView(animation: .filepath(path))
                    .playing()
                    .frame(width: 200, height: 200)
            }
            Text("Error: \(message)")
                .foregroundColor(AppColors.error)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            if !series { // Show the Retry button only if `series` is false
                Button("Retry") {
                    Task {
                        await viewModel.fetchHeroes()
                    }
                }
                .buttonStyle(BorderedButtonStyle())
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Preview
struct LottieErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = HeroListViewModel(useCase: HeroesUseCaseMock())
        Group {
            LottieErrorView(message: "Failed to load heroes", series: false)
                .environment(mockViewModel)
            
            LottieErrorView(message: "Failed to load series", series: true)
                .environment(mockViewModel)
        }
    }
}
#endif
