//
//  AppOfflineView.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 26/7/23.
//

import SwiftUI

struct AppOfflineView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.regularMaterial)
                .ignoresSafeArea()
            VStack {
                Text("No Network connection.")
                    .font(.headline)
                Text("App requires internet connection to work!")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct AppOfflineView_Previews: PreviewProvider {
    static var previews: some View {
        AppOfflineView()
    }
}
