import SwiftUI

/// A view that displays an error message using different subviews based on the platform.
struct ErrorView: View {
    /// The error message to display.
    private let message: String
    
    /// Indicates if the view is called from the series screen.
    private let series: Bool
    
    /// Initializes the `ErrorView`.
    /// - Parameters:
    ///   - message: The error message to display.
    ///   - series: A flag indicating if the view is called from the series screen. Defaults to `false`.
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

/// Preview provider for `ErrorView`.
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorView(message: "Failed to load heroes")
                .environment(HeroListViewModel())
            ErrorView(message: "Failed to load series", series: true)
                .environment(HeroListViewModel())
        }
        
    }
}
