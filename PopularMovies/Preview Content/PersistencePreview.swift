//
//  PersistencePreview.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

extension URL {
    static let popularMoviesTestURL = Bundle.main.url(forResource: "PopularMoviePageTest", withExtension: "json")
    static let genresTestURL = Bundle.main.url(forResource: "GenresTest", withExtension: "json")
}

extension MoviesVM {
    static let preview = MoviesVM(persistence: PersistencePreview())
}

final class PersistencePreview: PersistenceProtocol {
    var configuration = ConfigurationAPI.defaultConf
    
    static let shared = PersistencePreview()
    
    let doc = URL.cachesDirectory
    
    init() {
        
    }
    
    func getGenres() async throws -> [Genre] {
        guard let url = URL.genresTestURL,
              let genres = try? loadJSON(url: url, of: [Genre].self) else {
            throw NetworkError.badFilename
        }
        return genres
    }
    
    func getPopular() async throws -> [MovieResult] {
        guard let url = URL.popularMoviesTestURL,
              let page = try? loadJSON(url: url, of: PopularMoviePage.self) else {
            throw NetworkError.badFilename
        }
        return page.results
    }
    
    func getConfiguration() async throws -> ConfigurationAPI {
        return configuration
    }
    
    func getPoster(posterPath:String, callback: @escaping (UIImage?) -> Void) {
//        if let poster = try? getImage(posterPath: posterPath) {
//            callback(poster)
//        } else {
//            Task { @MainActor in
//                do {
//                    #if DEBUG
//                    try await Task.sleep(for: .seconds(0.2))
//                    #endif
//                    let image = try await getPosterNetwork(posterPath:posterPath)
//                    callback(image)
//                } catch {
//                    callback(nil)
//                }
//            }
//        }
    }
    
    
    func loadJSON<T:Codable>(url:URL, of: T.Type) throws -> T? {
 
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Loading error \(error)")
            return nil
        }
    }
    
    
    //TO-DO: - Review this code -|
    func getImage(posterPath:String) throws -> UIImage? {
        let path = String(posterPath.dropFirst())
        let components = path.components(separatedBy: ".")
        let docPath = doc.appending(path: path)
        if let url = Bundle.main.url(forResource: components[0], withExtension: components[1]) {
            return try loadImage(url: url)
        } else if FileManager.default.fileExists(atPath: docPath.path()) {
            return try loadImage(url: docPath)
        }
        return nil
    }
    
    func getPosterNetwork(posterPath:String) async throws -> UIImage {
        let image = try await Network.shared.getImage(url: .getImageURL(path: posterPath, conf: configuration.images, type: .poster))
        let docPath = doc.appending(path: posterPath)
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


