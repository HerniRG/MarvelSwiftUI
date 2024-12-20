import SwiftUI

struct AppColors {
    // Texto principal que se adapta al modo claro/oscuro
    static let text = Color.primary
    
    // Texto para el nombre del héroe, siempre blanco
    static let heroName = Color.white
    
    // Texto secundario que se adapta al modo claro/oscuro
    static let secondaryText = Color.secondary
    
    // Color de error fijo
    static let error = Color.red
    
    // Fondo principal de la aplicación
    static let background = Color.primary.opacity(0.05)
    
    // Fondo de tarjetas o contenedores
    static let cardBackground = Color.primary.opacity(0.1)
    
    // Superposición oscura para textos sobre fondos claros
    static let overlayDark = Color.black.opacity(0.7)
    
    // Colores para métricas específicas
    static let metricComics = Color.blue
    static let metricSeries = Color.green
    static let metricEvents = Color.orange
    
    // Color para indicadores de carga
    static let loadingIndicator = Color.red
    
    // Bordes y sombras
    static let border = Color.secondary.opacity(0.9)
    static let shadow = Color.black.opacity(0.15)
    
    // Colores para botones
    static let buttonBackground = Color.blue
    static let buttonForeground = Color.white
    
    // Enlaces
    static let link = Color.blue.opacity(0.7)
    
    // Éxito y advertencia
    static let success = Color.green
    static let warning = Color.yellow
    
    // Información
    static let info = Color.blue.opacity(0.5)
}
