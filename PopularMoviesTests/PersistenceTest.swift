//
//  PersistenceTest.swift
//  PopularMoviesTests
//
//  Created by Luis Lasierra on 25/7/23.
//

import XCTest

@testable import PopularMovies

final class PersistenceTest: XCTestCase {
    var persistence:ModelPersistence!
    var network:Network!
    
    override func setUpWithError() throws {
        persistence = .shared
        network = .shared
    }
    
    override func tearDownWithError() throws {
        network = nil
        persistence = nil
    }
    
    func testGetGenres() async throws { // -> [Genre]
        XCTAssertEqual(URL.getGenres.scheme, "https")
        XCTAssertEqual(URL.getGenres.host, "api.themoviedb.org")
        XCTAssertEqual(URL.getGenres.relativePath, "/3/genre/movie/list")
        //XCTAssertNoThrow(try await network.getJSON(request: .get(url: .getGenres, token: APIKEY), type: GenresAPI.self), "")
        let genres = try await Network.shared.getJSON(request: .get(url: .getGenres, token: APIKEY), type: GenresAPI.self).genres
        XCTAssertGreaterThan(genres.count, 0)
    }
    
    func testGetPopular() async throws { // -> [MovieResult]
        XCTAssertEqual(URL.popularMovies.scheme, "https")
        XCTAssertEqual(URL.popularMovies.host, "api.themoviedb.org")
        XCTAssertEqual(URL.popularMovies.relativePath, "/3/movie/popular")
        let popularMovies = try await Network.shared.getJSON(request: .get(url: .popularMovies, token: APIKEY), type: PopularMoviePage.self, decoder: .decoderWithDate).results
        XCTAssertGreaterThan(popularMovies.count, 0)
    }

    func testGetConfiguration() async throws { // -> ConfigurationAPI
        XCTAssertEqual(URL.popularMovies.scheme, "https")
        XCTAssertEqual(URL.popularMovies.host, "api.themoviedb.org")
        XCTAssertEqual(URL.popularMovies.relativePath, "/3/movie/popular")
        let config = try await Network.shared.getJSON(request: .get(url: .getConfiguration, token: APIKEY), type: ConfigurationAPI.self)
        XCTAssertFalse(config.images.secureBaseURL.pathComponents.isEmpty, "")
    }

    
    func testGetPosterNetwork() async throws { //(posterPath:String) async throws -> UIImage
        let posterPath = "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg"
        let configuration = persistence.configuration
        let image = try await network.getImage(url: .getImageURL(path: posterPath, conf: configuration.images, type: .poster))
        XCTAssertNotNil(image)
    }
    
    func testGetImage() async throws { //(posterPath:String) throws -> UIImage?
        let posterPath = "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg"
        let configuration = persistence.configuration
        let cachesDirectoryURL = persistence.doc
        let image = try await network.getImage(url: .getImageURL(path: posterPath, conf: configuration.images, type: .poster))
        XCTAssertNotNil(image)

//        let docURL = cachesDirectoryURL.appending(path: String(posterPath.dropFirst()))
//        XCTAssertTrue(FileManager.default.fileExists(atPath: docURL.path()))
//        let imageInCache = try persistence.loadImage(url: docURL)
//        XCTAssertNotNil(imageInCache)
    }

    
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
