//
//  Persistence.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

protocol PersistenceProtocol {
    var configuration: ConfigurationAPI { get }
    func getGenres() async throws -> [Genre]
    func getPopular() async throws -> [MovieResult]
    func getConfiguration() async throws -> ConfigurationAPI
    func getPoster(posterPath:String, callback: @escaping (UIImage?) -> Void)
}

final class ModelPersistence: PersistenceProtocol {
    var configuration = ConfigurationAPI.defaultConf
    
    static let shared = ModelPersistence()
    
    let doc = URL.cachesDirectory
    
    init() {
        Task {
            do {
                configuration = try await getConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    func getGenres() async throws -> [Genre] {
        try await Network.shared.getJSON(request: .get(url: .getGenres, token: APIKEY), type: GenresAPI.self).genres
    }
    
    func getPopular() async throws -> [MovieResult] {
        try await Network.shared.getJSON(request: .get(url: .popularMovies, token: APIKEY), type: PopularMoviePage.self, decoder: .decoderWithDate).results
    }
    
    func getConfiguration() async throws -> ConfigurationAPI {
        try await Network.shared.getJSON(request: .get(url: .getConfiguration, token: APIKEY), type: ConfigurationAPI.self)
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
