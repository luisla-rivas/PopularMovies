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
    @AppStorage("selectedLanguage", store: .standard) var selectedLanguage: String = "en"
    
    @StateObject var monitorNetwork = NetworkStatus()
    @StateObject var appVM = MoviesVM()
    
    let configuration = Configuration.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appVM)
                .preferredColorScheme(ColorScheme.init(
                    .init(rawValue: preferredColorScheme) ?? .light))
                .environment(\.locale, Locale(identifier: selectedLanguage))
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
