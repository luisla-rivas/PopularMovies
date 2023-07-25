//
//  LoadingView.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.regularMaterial)
                .ignoresSafeArea()
            VStack {
                ProgressView()
                    .controlSize(.large)
                    .padding(.bottom, 20)
                Text("Loading...")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
