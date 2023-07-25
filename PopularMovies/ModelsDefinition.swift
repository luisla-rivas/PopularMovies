//
//  ModelsDefinition.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import Foundation

import Foundation
// MARK: - MovieResult
struct MovieResult: Codable, Identifiable, Hashable {

    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    let releaseDate: Date
    let genreIDS: [Int]
    let voteAverage: Double
    let popularity: Double
    let voteCount: Int
    let adult: Bool
    let video: Bool

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
//// MARK: - MovieResult
//struct MovieResult: Codable, Identifiable, Hashable {
//    let id: Int
//    let title: String
//    let originalTitle: String
//    let overview: String
//    let posterPath: String
//    let backdropPath: String
//    let releaseDate: Date
//    let genreIDS: [Int]
//    let voteAverage: Double
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
//        case originalTitle = "original_title"
//        case overview
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title
//        case voteAverage = "vote_average"
//    }
//}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}
