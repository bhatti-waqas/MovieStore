//
//  MovieDataStoreTest.swift
//  CareemAssignmentTests
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import XCTest
@testable import CareemAssignment
class MovieDataStoreTest: XCTestCase {
    
    var dataStore:MoviesDataStore?
    var loadExpectation:XCTestExpectation = XCTestExpectation(description: "MoviesLoad")
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataStore = MoviesAPIDataStore()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        dataStore = nil
    }
    
    func testSearchTitle_LoadMoviesSuccessfully() {
        let searchWord = "martian"
        let requestModel = SearchAPIRequestModel()
        dataStore?.searchMovies(with: searchWord, page: "1", request: requestModel, onCompletion: { (result) in
            
            switch result {
                case .success(let data):
                    XCTAssertTrue(data.movies.count > 0, "Valid search word, movies list should not be zero.")
                    self.loadExpectation.fulfill()
                
            case .failure(let error):
                XCTFail("Search title failed :\(error.description)")
                self.loadExpectation.fulfill()
            }
        })
        wait(for: [loadExpectation], timeout: 10)
    }
    
    func testSearchTitle_WithEmojis_LoadMoviesSuccessfully() {
        let searchWord = "🤪😫"
        let requestModel = SearchAPIRequestModel()
        dataStore?.searchMovies(with: searchWord, page: "1", request: requestModel, onCompletion: { (result) in
            
            switch result {
                case .success(let data):
                    XCTAssertTrue(data.movies.count == 0, "Invalid emoji character search, movies list should be zero.")
                    self.loadExpectation.fulfill()
                
            case .failure(let error):
                XCTFail("Search with emoji character string failed :\(error.description)")
                self.loadExpectation.fulfill()
            }
        })
        wait(for: [loadExpectation], timeout: 10)
    }
    
    func testSearchTitle_InvalidQueryError() {
        let searchWord = "🤪😫"
        var requestModel = SearchAPIRequestModel()
        requestModel.apiKey = "blabla"
        dataStore?.searchMovies(with: searchWord, page: "1", request: requestModel, onCompletion: { (result) in
            switch result {
                case .success:
                    XCTFail("Invalid query parameters, this search should fail.")
                    self.loadExpectation.fulfill()
                
            case .failure(let error):
                XCTAssertNotNil(error, "Error should nt be nil")
                self.loadExpectation.fulfill()
            }
        })
        wait(for: [loadExpectation], timeout: 10)
    }
    
    func testSearchTitle_ErrorOn_InvalidQuery() {
        let dataStore = ErrorbMovieDataStore()
        let searchWord = "🤪😫"
        let requestModel = SearchAPIRequestModel()
        dataStore.searchMovies(with: searchWord, page: "1", request: requestModel, onCompletion: { (result) in
            switch result {
                case .success:
                    XCTFail("this search should fail.")
                    self.loadExpectation.fulfill()
                
            case .failure(let error):
                XCTAssertNotNil(error, "Error should nt be nil")
                self.loadExpectation.fulfill()
            }
        })
        wait(for: [loadExpectation], timeout: 10)
    }
}
