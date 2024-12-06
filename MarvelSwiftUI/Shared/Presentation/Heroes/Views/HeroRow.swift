import SwiftUI

struct HeroRow: View {
    let hero: ResultHero
    @State private var animate = false // Estado para controlar la animación
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                // Imagen con degradado y sombra
                AsyncImage(url: URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension.rawValue)")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 200)
                            .cornerRadius(12)
                        
                        // Fondo de imagen genérica
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.gray.opacity(0.4))
                        
                        // Degradado animado
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.5), Color.gray.opacity(0.3)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(height: 200)
                            .cornerRadius(12)
                            .opacity(0.5)
                            .mask(
                                // Máscara con un degradado suave
                                GeometryReader { geometry in
                                    LinearGradient(
                                        gradient: Gradient(colors: [.clear, .white.opacity(0.8), .clear]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                    .frame(width: geometry.size.width * 1.2)
                                    .offset(x: animate ? geometry.size.width : -geometry.size.width)
                                }
                            )
                            .onAppear {
                                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                                    animate = true
                                }
                            }
                    }
                }
                .cornerRadius(12)
                
                // Nombre del héroe sobre la imagen
                Text(hero.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Capsule())
                    .padding(12)
            }
            
            // Descripción e información adicional
            VStack(alignment: .leading, spacing: 10) {
                if !hero.description.isEmpty {
                    Text(hero.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                }
                
                HStack {
                    HStack {
                        Image(systemName: "book")
                            .foregroundColor(.blue)
                        Text("\(hero.comics.available) Comics")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    HStack {
                        Image(systemName: "film")
                            .foregroundColor(.green)
                        Text("\(hero.series.available) Series")
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
        )
    }
}

// MARK: - Preview
struct HeroRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeroRow(hero: ResultHero(
                id: 1011334,
                name: "3-D Man",
                description: "A classic Marvel character with unique powers.",
                modified: Date(),
                thumbnail: ThumbnailHero(
                    path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                    thumbnailExtension: .jpg
                ),
                resourceURI: "",
                comics: ComicsHero(available: 12, collectionURI: "", items: [], returned: 0),
                series: ComicsHero(available: 3, collectionURI: "", items: [], returned: 0),
                stories: StoriesHero(available: 5, collectionURI: "", items: [], returned: 0),
                events: ComicsHero(available: 1, collectionURI: "", items: [], returned: 0),
                urls: []
            ))
        }
        .padding()
    }
}
