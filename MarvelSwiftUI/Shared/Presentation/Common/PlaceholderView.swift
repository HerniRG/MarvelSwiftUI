//
//  PlaceholderView.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 8/12/24.
//

import SwiftUI

// MARK: - PlaceholderView para imágenes cargando
struct PlaceholderView: View {
    @Binding var animate: Bool // Controla la animación
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)
                .cornerRadius(16)
            
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
                .cornerRadius(16)
                .opacity(0.5)
                .mask(
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
}
