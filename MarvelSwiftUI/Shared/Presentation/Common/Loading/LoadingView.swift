import SwiftUI

struct LoadingView: View {
    var body: some View {
        #if os(watchOS)
        WatchLoadingView() // Loading básico para watchOS
        #else
        LottieLoadingView(animationName: "spider") // Lottie para iOS/macOS
        #endif
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
