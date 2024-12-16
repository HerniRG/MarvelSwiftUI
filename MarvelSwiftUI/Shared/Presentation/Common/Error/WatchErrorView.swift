import SwiftUI

struct WatchErrorView: View {
    @Environment(HeroListViewModel.self) var viewmodel
    let message: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle.fill") // Icono de error
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.red)
            
            Text("Error: \(message)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .fixedSize(horizontal: false, vertical: true) // Evita truncamiento y permite expansión vertical
                .padding(.horizontal, 16) // Añade espacio horizontal
                .padding(.top, 10)
            
            Button("Retry") {
                Task {
                    await viewmodel.fetchHeroes()
                }
            }
            .buttonStyle(BorderedButtonStyle())
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview
struct WatchErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = HeroListViewModel(useCase: HeroesUseCaseMock())
        WatchErrorView(message: "Something went wrong. Please try again. This is a very long error message to test wrapping on watchOS.")
            .environment(mockViewModel)
    }
}
