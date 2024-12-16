import SwiftUI

struct WatchLoadingView: View {
    @State private var isAnimating = false // Controla la animación
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.8) // Crea un círculo incompleto (efecto de progreso)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.red, .clear]),
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: 5, lineCap: .round)
                    )
                    .rotationEffect(.degrees(isAnimating ? 360 : 0)) // Rotación animada
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
struct WatchLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        WatchLoadingView()
    }
}
