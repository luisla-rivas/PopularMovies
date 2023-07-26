//
//  PreviewsTest.swift
//  PopularMoviesTests
//
//  Created by Luis Lasierra on 25/7/23.
//

import XCTest
@testable import PopularMovies

final class PreviewsTest: XCTestCase {
    
    var persistence:PersistencePreview!
    var moviesVM:MoviesVM!

    override func setUpWithError() throws {
        persistence = PersistencePreview() // inyección de los Fake
        moviesVM = MoviesVM()
    }

    override func tearDownWithError() throws {
        persistence = nil
        moviesVM = nil
    }
    
    func testGetGenres() async throws { // -> [Genre]
//        XCTAssertEqual(URL.getGenres(language: "en").scheme, "https")
//        XCTAssertEqual(URL.getGenres(language: "en").host, "api.themoviedb.org")
//        XCTAssertEqual(URL.getGenres(language: "en").relativePath, "/3/genre/movie/list")
//        //XCTAssertNoThrow(try await network.getJSON(request: .get(url: .getGenres, token: bearerToken), type: GenresAPI.self), "")
//        let genres = try await Network.shared.getJSON(request: .get(url: .getGenres(language: "en"), token: bearerToken), type: GenresAPI.self).genres
//        XCTAssertGreaterThan(genres.count, 0)
    }
    
    func testGetPopular() async throws { // -> [MovieResult]
//        XCTAssertEqual(URL.popularMovies(language: "en").scheme, "https")
//        XCTAssertEqual(URL.popularMovies(language: "en").host, "api.themoviedb.org")
//        XCTAssertEqual(URL.popularMovies(language: "en").relativePath, "/3/movie/popular")
//        let popularMovies = try await Network.shared.getJSON(request: .get(url: .popularMovies(language: "en"), token: bearerToken), type: PopularMoviePage.self, decoder: .decoderWithDate).results
//        XCTAssertGreaterThan(popularMovies.count, 0)
    }

    func testGetConfiguration() async throws { // -> ConfigurationAPI
//        XCTAssertEqual(URL.popularMovies(language: "en").scheme, "https")
//        XCTAssertEqual(URL.popularMovies(language: "en").host, "api.themoviedb.org")
//        XCTAssertEqual(URL.popularMovies(language: "en").relativePath, "/3/movie/popular")
//        let config = try await Network.shared.getJSON(request: .get(url: .getConfiguration, token: bearerToken), type: ConfigurationAPI.self)
//        XCTAssertFalse(config.images.secureBaseURL.pathComponents.isEmpty, "")
    }

    
    func testGetPosterNetwork() async throws { //(posterPath:String) async throws -> UIImage
//        let posterPath = "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg"
//        let configuration = persistence.configuration
//        let image = try await network.getImage(url: .getImageURL(path: posterPath, conf: configuration.images, type: .poster))
//        XCTAssertNotNil(image)
    }
    
    func testGetImage() async throws { //(posterPath:String) throws -> UIImage?
//        let posterPath = "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg"
//        let configuration = persistence.configuration
//        //let cachesDirectoryURL = persistence.doc
//        let image = try await network.getImage(url: .getImageURL(path: posterPath, conf: configuration.images, type: .poster))
//        XCTAssertNotNil(image)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
