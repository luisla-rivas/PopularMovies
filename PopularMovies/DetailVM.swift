//
//  DetailVM.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI
final class DetailVM: ObservableObject {
    let persistence = ModelPersistence.shared
    
    @Published var poster:UIImage?

    let movie:MovieResult

    init(movie:MovieResult) {
        self.movie = movie
        persistence.getPoster(posterPath: movie.posterPath) { poster in
            self.poster = poster
        }
    }
}
