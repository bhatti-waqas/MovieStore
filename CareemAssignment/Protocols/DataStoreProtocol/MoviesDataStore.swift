//
//  MoviesDataStore.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//


protocol MoviesDataStore {
    
    func searchMovies(with query:String, page:String, request: SearchAPIRequestModel, onCompletion : @escaping ResultHandler<SearchAPIResponseModel>)
}
