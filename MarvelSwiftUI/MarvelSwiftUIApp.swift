//
//  MarvelSwiftUIApp.swift
//  MarvelSwiftUI
//
//  Created by Hernán Rodríguez on 4/12/24.
//

import SwiftUI

@main
struct MarvelSwiftUIApp: App {
    @State var viewModel = HeroListViewModel()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(viewModel)
        }
    }
}
