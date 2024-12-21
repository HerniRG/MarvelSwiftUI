
import SwiftUI

/// A view that displays a loading animation, with platform-specific implementations.
struct LoadingView: View {
    var body: some View {
        #if os(watchOS)
        WatchLoadingView() // Basic loading view for watchOS
        #else
        LottieLoadingView(animationName: "spider") // Lottie animation for iOS/macOS
        #endif
    }
}

// MARK: - Preview
/// Preview provider for `LoadingView`.
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
