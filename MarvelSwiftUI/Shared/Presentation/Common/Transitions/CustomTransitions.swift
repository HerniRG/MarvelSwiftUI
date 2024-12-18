import SwiftUI

struct CustomTransitions {
    static func contentTransition() -> AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 1.1)),
            removal: .opacity.combined(with: .scale(scale: 0.9)).combined(with: .slide)
        )
    }
    
    static func loadingTransition() -> AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 1.2)).combined(with: .move(edge: .bottom)),
            removal: .opacity.combined(with: .scale(scale: 0.8)).combined(with: .move(edge: .top))
        )
    }
    
    static func errorTransition() -> AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 1.2)).combined(with: .move(edge: .top)),
            removal: .opacity.combined(with: .scale(scale: 0.8)).combined(with: .move(edge: .bottom))
        )
    }
}
