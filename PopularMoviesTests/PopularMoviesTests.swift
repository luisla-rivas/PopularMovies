//
//  PopularMoviesTests.swift
//  PopularMoviesTests
//
//  Created by Luis Lasierra on 25/7/23.
//

import XCTest

@testable import PopularMovies

final class PopularMoviesTests: XCTestCase {
    var persistence:ModelPersistence!
    var moviesVM:MoviesVM!
    
    
    override func setUpWithError() throws {
        persistence = .shared
        moviesVM = MoviesVM()
    }
    
    override func tearDownWithError() throws {
        moviesVM = nil
        persistence = nil
    }
    
    
    func testGetGenres() async throws -> [Genre] {
        try await Network.shared.getJSON(request: .get(url: .getGenres, token: bearerToken), type: GenresAPI.self).genres
    }
    
//    func testGetPopular() async throws -> [MovieResult] {
//        try await Network.shared.getJSON(request: .get(url: .popularMovies, token: bearerToken), type: PopularMoviePage.self, decoder: .decoderWithDate).results
//    }
//
//    func testGetNowPlaying() async throws -> [MovieResult] {
//        try await Network.shared.getJSON(request: .get(url: .nowPlaying, token: bearerToken), type: PopularMoviePage.self, decoder: .decoderWithDate).results
//    }
//
//    func testGetConfiguration() async throws -> ConfigurationAPI {
//        try await Network.shared.getJSON(request: .get(url: .getConfiguration, token: bearerToken), type: ConfigurationAPI.self)
//    }
//
//    func testGetPoster(posterPath:String, callback: @escaping (UIImage?) -> Void) {
//    }
        
        
        
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
