//
//  RowVM.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

final class RowVM:ObservableObject {
    let persistence: PersistenceProtocol
    
    @Published var poster:UIImage?
    
    let movie:MovieResult
    
    init(movie:MovieResult, persistence: PersistenceProtocol) {
        self.persistence = persistence
        self.movie = movie
        persistence.getPoster(posterPath: movie.posterPath) { poster in
            self.poster = poster
        }
    }
}
