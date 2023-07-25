//
//  Interface.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import Foundation
let APIKEY = ""

extension URLQueryItem {
    static let language = URLQueryItem(name: "language", value: "es-ES")
    static let region = URLQueryItem(name: "region", value: "ES")
}

extension URL {
    static let movieAPI = URL(string: "https://api.themoviedb.org/3/")!
    static let popularMovies = movieAPI.appending(path: "movie/popular")
    static let nowPlaying = movieAPI.appending(path: "movie/now_playing")
        .appending (queryItems: [. language, .region])
    static let getGenres = movieAPI.appending (path: "genre/movie/list")
        .appending(queryItems: [.language])
    static let getConfiguration = movieAPI.appending (path: "configuration")
    
    static func getImageURL(path:String, conf:Images, type:ImageType) -> URL {
        let baseURL = conf.secureBaseURL
        switch type {
        case .backdrop:
            return baseURL
                .appending(path: conf.backdropSizes.dropLast().last ?? "")
                .appending(path: path)
        case .logo:
            return baseURL
                .appending(path: conf.logoSizes.dropLast().last ?? "")
                .appending(path: path)
        case .poster:
            return baseURL
                .appending(path: conf.posterSizes.dropLast().last ?? "")
                .appending(path: path)
        case .profile:
            return baseURL
                .appending(path: conf.profileSizes.dropLast().last ?? "")
                .appending(path: path)
        case .still:
            return baseURL
                .appending(path: conf.stillSizes.dropLast().last ?? "")
                .appending(path: path)
        }
    }
}

enum ImageType {
    case backdrop, logo, poster, profile, still
}
