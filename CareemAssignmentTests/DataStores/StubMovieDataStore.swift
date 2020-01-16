//
//  StubMovieDataStore.swift
//  CareemAssignmentTests
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import XCTest
@testable import CareemAssignment
class ErrorbMovieDataStore: MoviesDataStore {
    
    func searchMovies(with query: String, page: String, request: SearchAPIRequestModel, onCompletion: @escaping ResultHandler<SearchAPIResponseModel>) {
        let error:NetworkError = .ServerError(message: "Something went wrong or network issue")
        let result:ResultType<SearchAPIResponseModel> = .failure(error)
        
        onCompletion(result)
    }
}
