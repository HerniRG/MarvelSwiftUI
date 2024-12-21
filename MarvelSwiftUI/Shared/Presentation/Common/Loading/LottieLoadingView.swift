import SwiftUI
#if !os(watchOS)
import Lottie
#endif

#if !os(watchOS)
/// A view that displays a Lottie animation and a loading message.
struct LottieLoadingView: View {
    /// The name of the Lottie animation file.
    let animationName: String
    
    var body: some View {
        VStack {
            if let path = Bundle.main.path(forResource: animationName, ofType: "json") {
                LottieView(animation: .filepath(path))
                    .looping()
                    .frame(width: 200, height: 200)
            }
            Text("Loading...")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Preview
/// Preview provider for `LottieLoadingView`.
struct LottieLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LottieLoadingView(animationName: "spider")
    }
}
#endif
