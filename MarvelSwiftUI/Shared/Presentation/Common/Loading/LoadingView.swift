import SwiftUI

#if !os(watchOS)
import Lottie
#endif

struct LoadingView: View {
    var body: some View {
#if os(watchOS)
        WatchLoadingView() // Loading básico para watchOS
#else
        LottieLoadingView(animationName: "spider") // Lottie para iOS/macOS
#endif
    }
}

#if !os(watchOS)
struct LottieLoadingView: View {
    let animationName: String
    
    var body: some View {
        VStack {
            if let path = Bundle.main.path(forResource: animationName, ofType: "json") {
                LottieView(animation: .filepath(path))
                    .looping()
                    .frame(width: 200, height: 200)
            }
            // Texto debajo de la animación
            Text("Loading...")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}
#endif

struct WatchLoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
            Text("M")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
