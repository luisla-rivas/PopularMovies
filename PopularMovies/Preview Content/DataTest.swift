//
//  DataTest.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import Foundation

extension MovieResult {
    static let preview = MovieResult(id: 916224, title: "Suzume", originalTitle: "すずめの戸締まり",originalLanguage:"Japanese", overview: "Suzume, una joven chica de 17 años que vive en un pueblo tranquilo en la región de Kyushu, en el suroeste de Japón. La historia comienza cuando Suzume conoce a un misterioso joven que busca una \"puerta\". Los dos viajan juntos y encuentran una puerta vieja en una casa abandonada en las montañas. Como si algo tirara de ella, Suzume extiende su mano hacia la puerta, lo que comienza una serie de eventos desafortunados en todo Japón.", posterPath: "/iUfWPVyuLA4wZ5EetHyyGsi25SF.jpg", backdropPath: "/ceYZCBfwbBwSpGJ6PapNVw5jqLG.jpg", releaseDate: DateFormatter.formato.date(from: "2023-04-14")!, genreIDS: [16,18,12,14], voteAverage: 8.2, popularity: 1522, voteCount: 1256, adult: false, video: false)
}

//FIXME: Arreglar
//struct DataPreview: DataLocation {
//        var dataURL: URL {
//                Bundle.main.url(forResource: "PopularMoviePageTest", withExtension: "json")!
//    }
//}
//
//
//extension Movie {
//    static let test = Movie(id: 157336,
//        title: "Interstellar",
//        overview: "The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.
//        runtime: 169, vote_average: 8.3,
//        external_ids: Links(imdb_id: "tt0816692", facebook_id: "Interstellarmovie", instagram_id: "interstellarmovie"
//        twitter_id: "interstellar"),
//        release_date: DateFormatter.fechaFormatter.ate(from: "2814-11-05") 1, poster _path:
//        poster_path: URL(string: "https: //image.tmdb.org/t/p/w500/gEU2QniE6E77NI61CU6M×INBvIx.jpg")!,
//        tagline: "Mankind was born on Earth. It was never meant to die here.",
//        cast: [CastCrew(id: 10297, name: "Matthew McConaughey"),
//                    CastCrew(id: 83002, name: "Jessica Chastain"),
//                    CastCrew(id: 1813, name: "Anne Hathaway")],
//        directors: [CastCrew(id: 525, name: "Christopher Nolan")],
//            writers: [CastCrew(id: 525, name: "Christopher Nolan"),
//                                CastCrew(id: 527, name: "Jonathan Nolan")
//        ])
//}
//
//extension MoviesVM {
//    static let preview = MoviesVM(persistence: Persistence(dataLocation: DataPreview()))
//}
