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
    
    func testLoadJSON() async throws {
//        XCTAssertEqual(URL.popularMoviesTestURL!.lastPathComponent, "PopularMoviePageTest.json")
//        XCTAssertNoThrow(try persistence.loadJSON(url: URL.popularMoviesTestURL!, of: PopularMoviePage.self), "")
//        let page = try XCTUnwrap(persistence.loadJSON(url: URL.popularMoviesTestURL!, of: PopularMoviePage.self), "expected non-nil value")
//        XCTAssertGreaterThan(page.results.count, 0)
        
        XCTAssertEqual(URL.genresTestURL!.lastPathComponent, "GenresTest.json")
        XCTAssertNoThrow(try persistence.loadJSON(url: URL.genresTestURL!, of: [Genre].self), "")
        let genres = try XCTUnwrap(persistence.loadJSON(url: URL.genresTestURL!, of: [Genre].self), "expected non-nil value")
        XCTAssertGreaterThan(genres.count, 0)
    }

    
//    func testGetGenres() async throws { // -> [Genre]
//        loadJSON(url: .genresTestURL, arrayOf: Genre.self)
//    }
//
//    func testGetPopular() async throws {// -> [MovieResult]
//        loadJSON(url: .popularMoviesTestURL, arrayOf: MovieResult.self)
//    }
//
//    func testGetConfiguration() async throws {// -> ConfigurationAPI
//        return configuration
//    }
//
//    func testGetPoster(posterPath:String, callback: @escaping (UIImage?) -> Void) {
//    }
    
//    func testLoadData() async throws {
//            await moviesVM.getInitialData()
//            XCTAssertGreaterThan(bookVM.books.count, 0)
//            XCTAssertGreaterThan(bookVM.authors.count, 0)
//    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
