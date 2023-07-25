//
//  PopularMoviesListView.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

struct PopularMoviesListView: View {
    @EnvironmentObject var appVM:MoviesVM
    //@Namespace var namespace
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(appVM.movies) { movie in
                    NavigationLink(value: movie) {
                        RowView(vm: RowVM(movie: movie))
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Popular movies")
            .navigationDestination(for: MovieResult.self) { movie in
                MovieDetailView(vm: DetailVM(movie: movie))
            }
        }
    }
}

struct PopularMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesListView()
            .environmentObject(MoviesVM())
    }
}
