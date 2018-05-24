//
//  MovieDatabaseTests.swift
//  MovieDatabaseTests
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import XCTest
import Moya
@testable import MovieDatabase

class MovieDatabaseTests: XCTestCase {
    var provider: MoyaProvider<MovieDBService>!
    
    override func setUp() {
        super.setUp()
        provider = MoyaProvider<MovieDBService>(stubClosure: MoyaProvider.immediatelyStub)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: - Model decoding test
    func testMoviesRequestResponseDecoder() {
        let target: MovieDBService = .newMovies(page: 1)
        let samleData = target.sampleData
        do {
            let moviesResponse = try JSONDecoder().decode(MoviesRequestResponse.self, from: samleData)
            XCTAssertTrue(moviesResponse.totalResults == 1009 && moviesResponse.movies.count == 20 && moviesResponse.totalPages == 51)
        } catch let error {
            XCTAssertThrowsError(error)
        }
    }
    
    func testMovieDetailsDecoder() {
        let target: MovieDBService = .movieDetails(id: 157336)
        let samleData = target.sampleData
        do {
            let moviesDetails = try JSONDecoder().decode(MovieDetails.self, from: samleData)
            XCTAssertTrue(moviesDetails.budget == 165000000 && moviesDetails.videos.count == 9)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    //MARK: - API
    func testServiceNewMoviesRequest() { //WE can't compare live and sample data, because live data changes with new movies releases, so just test on succesfull request.
        provider.request(.newMovies(page: 1)) { result in
            switch result {
            case .success(_):
                XCTAssertTrue(true)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testServiceSearchMovies() {
        var message: String?
        let target: MovieDBService = .searchMovies(searchString: "Deadpool 2", page: 1)
        let sampleData = target.sampleData
        
        provider.request(target) { result in
            if case let .success(response) = result {
                message = String(data: response.data, encoding: .utf8)
            } else {
                XCTAssertTrue(false)
            }
        }
        
        XCTAssertEqual(message, String(data: sampleData, encoding: .utf8))
    }
    
    func testServiceMovieDetails() {
        var message: String?
        let target: MovieDBService = .movieDetails(id: 157336)
        let sampleData = target.sampleData
        
        provider.request(target) { result in
            if case let .success(response) = result {
                message = String(data: response.data, encoding: .utf8)
            } else {
                XCTAssertTrue(false)
            }
        }
        XCTAssertEqual(message, String(data: sampleData, encoding: .utf8))
    }
    
    
    //MARK: - NetworkManager
    func testGetMovies() {
        let expect = expectation(description: "Get new movies")
        NetworkManager.getNewMovies(page: 1) { error, movies, totalPages in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertTrue(movies.count > 0 && totalPages > 0)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Expectation with timeout failed with error: \(error)")
            }
        }
    }
    
    func testGetMoviesFail() {
         let expect = expectation(description: "Get error, eg max page count = 1000")
        NetworkManager.getNewMovies(page: 99999999) { error, movies, totalPages in
            XCTAssertTrue(error != nil)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Expectation with timeout failed with error: \(error)")
            }
        }
        
    }
    
    func testSearchMovies() {
        let expect = expectation(description: "Search for Deadpool 2 movie info")
        NetworkManager.searchMovie(searchString: "Deadpool 2", page: 1) { error, movies, totalPages in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertTrue(movies.count == 1 && totalPages == 1)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Expectation with timeout failed with error: \(error)")
            }
        }
    }
    
    func testSearchMoviesFail() {
        let expect = expectation(description: "Search for Deadpool 2 movie info with wrong page number. ")
        NetworkManager.searchMovie(searchString: "Deadpool 2", page: 99999) { error, movies, totalPages in
            XCTAssertTrue(error != nil)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Expectation with timeout failed with error: \(error)")
            }
        }
    }
    
    func testMovieDetails() {
        let expect = expectation(description: "Search for Interstellar movie detailed info")
        let movieID = 157336
        NetworkManager.getMovieDetails(id: movieID) { error, movieDetails in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            if let movieDetails = movieDetails {
            XCTAssertTrue(movieDetails.id == movieID)
            } else {
                XCTAssertTrue(false)
            }
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Expectation with timeout failed with error: \(error)")
            }
        }
    }
    
    func testMovieDetailsFail() {
        let expect = expectation(description: "Get detailed info for wrong id")
        let movieID = 999999999
        NetworkManager.getMovieDetails(id: movieID) { error, movieDetails in
            XCTAssertTrue(error != nil)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Expectation with timeout failed with error: \(error)")
            }
        }
    }
    
}
