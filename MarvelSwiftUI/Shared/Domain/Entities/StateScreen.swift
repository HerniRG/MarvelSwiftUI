import Foundation

/// Represents the various states of a screen.
enum StateScreen: Equatable {
    /// The screen is currently loading.
    case loading
    
    /// The screen has successfully loaded data.
    case loaded
    
    /// The screen encountered an error.
    /// - Parameter message: A description of the error.
    case error(String)
}
