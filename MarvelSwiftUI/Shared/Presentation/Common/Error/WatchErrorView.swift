import SwiftUI

/// A view that displays an error message and an optional retry button for watchOS.
struct WatchErrorView: View {
    /// The view model handling the hero list logic.
    @Environment(HeroListViewModel.self) var viewModel
    
    /// The error message to display.
    let message: String
    
    /// Indicates if the error view is called from the series screen.
    let series: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(AppColors.error)
            
            Text("Error: \(message)")
                .foregroundColor(AppColors.error)
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 16)
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
    }
}

// MARK: - Preview
/// Preview provider for `WatchErrorView`.
struct WatchErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = HeroListViewModel(useCase: HeroesUseCaseMock())
        WatchErrorView(message: "Something went wrong. Please try again. This is a very long error message to test wrapping on watchOS.", series: false)
            .environment(mockViewModel)
    }
}
