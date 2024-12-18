import SwiftUI

struct WatchErrorView: View {
    @Environment(HeroListViewModel.self) var viewmodel
    let message: String
    let series: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.red)
            
            Text("Error: \(message)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 16)
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
    }
}
// MARK: - Preview
struct WatchErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = HeroListViewModel(useCase: HeroesUseCaseMock())
        WatchErrorView(message: "Something went wrong. Please try again. This is a very long error message to test wrapping on watchOS.", series: false)
            .environment(mockViewModel)
    }
}
