import SwiftUI

/// A struct that defines custom view transitions used throughout the app.
struct CustomTransitions {
    /// Transition for content views, combining opacity, scale, and slide effects.
    /// - Returns: An `AnyTransition` object for content insertion and removal.
    static func contentTransition() -> AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 1.1)),
            removal: .opacity.combined(with: .scale(scale: 0.9)).combined(with: .slide)
        )
    }
    
    /// Transition for loading views, combining opacity, scale, and movement from the bottom.
    /// - Returns: An `AnyTransition` object for loading insertion and removal.
    static func loadingTransition() -> AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 1.2)).combined(with: .move(edge: .bottom)),
            removal: .opacity.combined(with: .scale(scale: 0.8)).combined(with: .move(edge: .top))
        )
    }
    
    /// Transition for error views, combining opacity, scale, and movement from the top.
    /// - Returns: An `AnyTransition` object for error insertion and removal.
    static func errorTransition() -> AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 1.2)).combined(with: .move(edge: .top)),
            removal: .opacity.combined(with: .scale(scale: 0.8)).combined(with: .move(edge: .bottom))
        )
    }
}
