//
//  ErrorView.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 8/12/24.
//

import SwiftUI

#if !os(watchOS)
import Lottie
#endif

struct ErrorView: View {
    private let message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        #if os(watchOS)
        WatchErrorView(message: message) // Error básico para watchOS
        #else
        LottieErrorView(message: message, animationName: "error") // Lottie para iOS/macOS
        #endif
    }
}

#if !os(watchOS)
struct LottieErrorView: View {
    @Environment(HeroListViewModel.self) var viewmodel
    let message: String
    let animationName: String
    
    var body: some View {
        VStack {
            if let path = Bundle.main.path(forResource: animationName, ofType: "json") {
                LottieView(animation: .filepath(path))
                    .playing()
                    .frame(width: 200, height: 200)
            }
            Text("Error: \(message)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            Button("Retry") {
                Task {
                    await viewmodel.fetchHeroes()
                }
            }
            .buttonStyle(BorderedButtonStyle())
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}
#endif

struct WatchErrorView: View {
    @Environment(HeroListViewModel.self) var viewmodel
    let message: String
    
    var body: some View {
        VStack {
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
            Text("Error: \(message)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            Button("Retry") {
                Task {
                    await viewmodel.fetchHeroes()
                }
            }
            .buttonStyle(BorderedButtonStyle())
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Something went wrong")
            .environment(HeroListViewModel())
    }
}
