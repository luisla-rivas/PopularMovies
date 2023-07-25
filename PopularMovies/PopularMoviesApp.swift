//
//  PopularMoviesApp.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

@main
struct PopularMoviesApp: App {
    @StateObject var appVM = MoviesVM()
    
    let configuration = Configuration.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appVM)
//                .overlay {
//                    if appVM.loading != .data {
//                        LoadingView()
//                            .transition(.opacity)
//                    }
//                    .animation (.default, value: appVM.loading)
//                    .onAppear {
//                        print(URL.documentsDirectory)
//                    }
//                }
        }
    }
}
