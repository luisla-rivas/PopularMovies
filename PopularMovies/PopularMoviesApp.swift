//
//  PopularMoviesApp.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

@main
struct PopularMoviesApp: App {
    @AppStorage("preferredColorScheme") var preferredColorScheme: Int = 0
    
    @StateObject var monitorNetwork = NetworkStatus()
    @StateObject var appVM = MoviesVM()
    
    let configuration = Configuration.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appVM)
                .preferredColorScheme(ColorScheme.init(
                    .init(rawValue: preferredColorScheme) ?? .light))
                .overlay {
                    if monitorNetwork.status == .offline {
                        AppOfflineView()
                            .transition(.opacity)
                    }
                }
            
//                .overlay {
//                    if appVM.loading != true {
//                        LoadingView()
//                            .transition(.opacity)
//                    }
//                    .animation(.default, value: appVM.loading)
//                }
        }
    }
}
