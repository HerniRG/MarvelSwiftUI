//import SwiftUI
//
//// MARK: - HeroListView
//struct HeroListView: View {
//    let heroes = mockHeroes
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 24) {
//                    ForEach(heroes, id: \.id) { hero in
//                        HeroRow(hero: hero)
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.top, 8) // Separación inicial
//            }
//            .navigationTitle("Marvel Heroes")
//        }
//    }
//}
//
//// MARK: - Preview
//struct HeroListView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            HeroListView()
//                .previewDevice("iPhone 14")
//            HeroListView()
//                .previewDevice("iPad Pro (12.9-inch)")
//            HeroListView()
//                .previewDevice("Apple Watch Series 8 - 45mm")
//            HeroListView()
//                .frame(width: 800, height: 600) // macOS
//        }
//    }
//}
