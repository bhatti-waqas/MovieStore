//
//  MovieCellViewModelTest.swift
//  CareemAssignmentTests
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import XCTest
@testable import CareemAssignment
class MovieCellViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testName_ShouldReturnErrorOnEmptyTitle() {
        let movie = Movie()
        movie.title = ""
        let cellViewModel = MovieCellViewModel(movie: movie)
        XCTAssertEqual(cellViewModel.title, "No Title")
        
    }
    
    func testName_ShouldReturnErrorOnEmptyOverView() {
        let movie = Movie()
        movie.overview = ""
        let cellViewModel = MovieCellViewModel(movie: movie)
        XCTAssertEqual(cellViewModel.overView, "No Overview")
        
    }

}
