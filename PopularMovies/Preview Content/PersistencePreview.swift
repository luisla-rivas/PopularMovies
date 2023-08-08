//
//  PersistencePreview.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

extension URL {
    static let popularMoviesTestFileURL = Bundle.main.url(forResource: "PopularMoviePageTest", withExtension: "json")!
    static let genresTestFileURL = Bundle.main.url(forResource: "GenresTest", withExtension: "json")!
}

extension MoviesVM {
    static let preview = MoviesVM(persistence: PersistencePreview())
}

final class PersistencePreview: PersistenceProtocol {
    var configuration = ConfigurationAPI.defaultConf
    
    static let shared = PersistencePreview()
    
    let cacheDirectory = URL.cachesDirectory
    
    init() {
        //print("Init of PersistencePreview")
    }
    
    func getGenres(language: String) async throws -> [Genre] {
        let data = try Data(contentsOf: .genresTestFileURL)
        let genres = try JSONDecoder().decode(GenresAPI.self, from: data).genres
        //print("Generos \(genres[0])")
        return genres
    }
    
    func getPopular(language: String) async throws -> [MovieResult] {
        let data = try Data(contentsOf: .popularMoviesTestFileURL)
        let popularMovies = try JSONDecoder.decoderWithDate.decode(PopularMoviePage.self, from: data).results
        return popularMovies
    }
    
    func getPopularPage(_ page: Int, language: String) async throws -> PopularMoviePage {
        let data = try Data(contentsOf: .popularMoviesTestFileURL)
        let popularMoviePage = try JSONDecoder.decoderWithDate.decode(PopularMoviePage.self, from: data)
        return popularMoviePage
    }
    
    
    func getConfiguration() async throws -> ConfigurationAPI {
        return configuration
    }
    
    func getPoster(posterPath:String, callback: @escaping (UIImage?) -> Void) {
        if let poster = try? getImage(posterPath: posterPath) {
            callback(poster)
        } else {
            Task { @MainActor in
                do {
                    #if DEBUG
                    try await Task.sleep(for: .seconds(0.2))
                    #endif
                    let image = try await getPosterNetwork(posterPath:posterPath)
                    callback(image)
                } catch {
                    callback(nil)
                }
            }
        }
    }
    
    func getImage(posterPath:String) throws -> UIImage? {
        let path = String(posterPath.dropFirst())
        let components = path.components(separatedBy: ".")
        let docPath = cacheDirectory.appending(path: path)
        print(path)
        print(components[0])
        print(components[1])
        if let url = Bundle.main.url(forResource: components[0], withExtension: components[1]) {
            print("Esta en el bundle, para las preview")
            return try loadImage(url: url)
        } else if FileManager.default.fileExists(atPath: docPath.path()) {
            print("Esta en el directorio de cache")
            return try loadImage(url: docPath)
        }
        return nil
    }
    
    func getPosterNetwork(posterPath:String) async throws -> UIImage {
        let image = try await Network.shared.getImage(url: .getImageURL(path: posterPath, conf: configuration.images, type: .poster))
        let docPath = cacheDirectory.appending(path: posterPath)
        if let data = image.jpegData(compressionQuality: 0.7) {
            try data.write(to: docPath, options: [.atomic])
        }
        return image
    }
    
    func loadImage(url:URL) throws -> UIImage? {
        let data = try Data(contentsOf: url)
        return UIImage(data: data)
    }
    
}


