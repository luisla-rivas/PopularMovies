//
//  MoviesVM.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

final class MoviesVM:ObservableObject {
    let persistence: PersistenceProtocol
    
    @Published var genres:[Genre] = []
    @Published var movies:[MovieResult] = []
    
    @Published var selectedMovie:MovieResult?
    
    @Published var loading = true
    
    init(persistence: PersistenceProtocol = ModelPersistence.shared) {
        self.persistence = persistence
        Task { await initData() }
    }
    
    @MainActor func initData() async {
        do {
            (genres, movies) = try await (persistence.getGenres(), persistence.getPopular())
            //(genres, movies) = try await (persistence.getGenres(), persistence.getNowPlaying())
            try await Task.sleep(for: .seconds(1))
            loading = false
        } catch {
            print(error)
        }
    }
    
    func getProfilePath(profilePath:String) -> URL {
        .getImageURL(path: profilePath, conf: self.persistence.configuration.images, type: .profile)
    }
    
    func getBackdropPath(backdropPath:String) -> URL {
        .getImageURL(path: backdropPath, conf: self.persistence.configuration.images, type: .backdrop)
    }
}


