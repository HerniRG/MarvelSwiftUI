import SwiftUI
#if !os(watchOS)
import Lottie
#endif

#if !os(watchOS)
struct LottieErrorView: View {
    @Environment(HeroListViewModel.self) var viewmodel
    let message: String
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
            
            if !series { // Muestra el botón Retry solo si `series` es false
                Button("Retry") {
                    Task {
                        await viewmodel.fetchHeroes()
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
        LottieErrorView(message: "Something went wrong", series: false)
            .environment(mockViewModel)
    }
}
#endif
