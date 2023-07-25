//
//  ModelsAPI.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let popularMoviePage = try? JSONDecoder().decode(PopularMoviePage.self, from: jsonData)

import Foundation

// MARK: - PopularMoviePage
// https://developer.themoviedb.org/reference/movie-popular-list
struct PopularMoviePage: Codable {
    let page: Int
    let results: [MovieResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case es = "es"
//    case pl = "pl"
//    case uk = "uk"
//}

// MARK: - GenresAPI
struct GenresAPI: Codable {
    let genres: [Genre]
}

// MARK: - ConfigurationAPI
struct ConfigurationAPI: Codable {
    let images: Images
}

extension ConfigurationAPI {
    static let defaultConf: ConfigurationAPI = .init(images: Images(secureBaseURL: URL(string: "https://image.tmdb.org/t/p/")!,
                                                         backdropSizes: ["w300","w780","w1280","original"],
                                                         logoSizes: ["w45","w92","w154","w185","w300","w500","original"],
                                                         posterSizes: ["w92","w154","w185","w342","w500","w700","original"],
                                                         profileSizes: ["w45","w185","h632","original"],
                                                         stillSizes: ["w92","w185","w300","original"]))
}

// MARK: - Images
struct Images: Codable {
    let secureBaseURL: URL
    let backdropSizes, logoSizes, posterSizes, profileSizes: [String]
    let stillSizes: [String]

    enum CodingKeys: String, CodingKey {
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}
