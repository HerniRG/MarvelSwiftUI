import SwiftUI

struct ErrorView: View {
    private let message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        #if os(watchOS)
        WatchErrorView(message: message) // Error básico para watchOS
        #else
        LottieErrorView(message: message, animationName: "error") // Lottie para iOS/macOS
        #endif
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Something went wrong")
            .environment(HeroListViewModel())
    }
}
