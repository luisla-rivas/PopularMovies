//
//  ContentView.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI
enum TabItem {
  case popular, setting
}

struct ContentView: View {
    @State private var selection: TabItem = .popular

    var body: some View {
        TabView(selection: $selection) {
            PopularMoviesListView()
                .tabItem {
                    Label("Popular", systemImage: "list.and.film")
                    }
                .tag(TabItem.popular)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                    }
                .tag(TabItem.setting)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
