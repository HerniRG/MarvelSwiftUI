import SwiftUI

/// A simple loading view with a spinning animation, designed for watchOS.
struct WatchLoadingView: View {
    /// Controls the spinning animation.
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.8) // Creates an incomplete circle (progress effect)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.red, .clear]),
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: 5, lineCap: .round)
                    )
                    .rotationEffect(.degrees(isAnimating ? 360 : 0)) // Rotating animation
                    .frame(width: 50, height: 50)
                    .onAppear {
                        withAnimation(
                            Animation.linear(duration: 1.0)
                                .repeatForever(autoreverses: false)
                        ) {
                            isAnimating = true
                        }
                    }
            }
            Text("Loading...")
                .font(.headline)
                .foregroundColor(.red)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview
/// Preview provider for `WatchLoadingView`.
struct WatchLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        WatchLoadingView()
    }
}
