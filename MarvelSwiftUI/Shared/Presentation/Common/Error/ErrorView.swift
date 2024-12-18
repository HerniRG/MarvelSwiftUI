import SwiftUI

struct ErrorView: View {
    private let message: String
    private let series: Bool
    
    init(message: String, series: Bool = false) { 
        self.message = message
        self.series = series
    }
    
    var body: some View {
        #if os(watchOS)
        WatchErrorView(message: message, series: series)
        #else
        LottieErrorView(message: message, series: series)
        #endif
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Something went wrong")
            .environment(HeroListViewModel())
    }
}
