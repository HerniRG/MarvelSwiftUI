import SwiftUI

struct HeroRow: View {
    let hero: ResultHero

    var body: some View {
#if os(watchOS)
        HeroRowCompact(hero: hero) // Diseño específico para watchOS
#else
        HeroRowDefault(hero: hero) // Diseño para todas las demás plataformas
#endif
    }
}
