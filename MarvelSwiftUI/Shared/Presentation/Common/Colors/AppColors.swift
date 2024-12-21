import SwiftUI

/// Defines the color palette used throughout the app.
struct AppColors {
    /// Primary text color that adapts to light/dark mode.
    static let text = Color.primary
    
    /// Hero name text color, always white.
    static let heroName = Color.white
    
    /// Secondary text color that adapts to light/dark mode.
    static let secondaryText = Color.secondary
    
    /// Fixed error color.
    static let error = Color.red
    
    /// Main background color of the app.
    static let background = Color.primary.opacity(0.05)
    
    /// Background color for cards or containers.
    static let cardBackground = Color.primary.opacity(0.1)
    
    /// Dark overlay for text on light backgrounds.
    static let overlayDark = Color.black.opacity(0.7)
    
    /// Color for comics metrics.
    static let metricComics = Color.blue
    
    /// Color for series metrics.
    static let metricSeries = Color.green
    
    /// Color for events metrics.
    static let metricEvents = Color.orange
    
    /// Color for loading indicators.
    static let loadingIndicator = Color.red
    
    /// Border color with slight opacity.
    static let border = Color.secondary.opacity(0.9)
    
    /// Shadow color with reduced opacity.
    static let shadow = Color.black.opacity(0.15)
    
    /// Background color for buttons.
    static let buttonBackground = Color.blue
    
    /// Foreground (text) color for buttons.
    static let buttonForeground = Color.white
    
    /// Color for hyperlinks.
    static let link = Color.blue.opacity(0.7)
    
    /// Color indicating success.
    static let success = Color.green
    
    /// Color indicating a warning.
    static let warning = Color.yellow
    
    /// Color for informational messages.
    static let info = Color.blue.opacity(0.5)
}
