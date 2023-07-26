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
    @Published var languageID: Iso_639_1 = "en"
    
    @Published var loading = true
    
    @Published var showError = false
    @Published var errorMsg = "" {
        didSet {
            if !errorMsg.isEmpty {
                showError.toggle()
            }
        }
    }
    
    init(persistence: PersistenceProtocol = ModelPersistence.shared) {
        self.persistence = persistence
        self.languageID = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
        Task { await initData() }
    }
    
    @MainActor func initData() async {
        do {
            (genres, movies) = try await (persistence.getGenres(language: languageID), persistence.getPopular(language: languageID))
            //movies = []
            //try await Task.sleep(for: .seconds(1))
            loading = false
            print("loaded")
        } catch let error as NetworkError {
            errorMsg = error.description
        } catch {
            errorMsg = error.localizedDescription
        }
    }
    
    func getProfilePath(profilePath:String) -> URL {
        .getImageURL(path: profilePath, conf: self.persistence.configuration.images, type: .profile)
    }
    
    func getBackdropPath(backdropPath:String) -> URL {
        .getImageURL(path: backdropPath, conf: self.persistence.configuration.images, type: .backdrop)
    }
    
    func genresFor(_ movie: MovieResult) -> [String] {
        if !movie.genreIDS.isEmpty {
            return movie.genreIDS.compactMap { numericCode in
                genres.first(where: { $0.id == numericCode })?.name
            }
        } else {
            return []
        }
    }
    
    let languages = [
        Language(id: "en", name: "English", nativeName: "English"),
        Language(id: "es", name: "Spanish", nativeName: "Español"),
        Language(id: "fr", name: "French", nativeName: "Français"),
        Language(id: "de", name: "German", nativeName: "Deutsch"),
    ]
    
    let defaultLanguage = Language(id:"en", name: "English", nativeName: "English")
}


