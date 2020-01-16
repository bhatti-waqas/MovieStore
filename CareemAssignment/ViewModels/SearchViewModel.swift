//
//  SearchViewModel.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

class SearchViewModel: BaseViewModel {
    
    private var response:SearchAPIResponseModel?
    private var currentQuery: String? = nil
    private var currentPage: Int = 0
    private let request = SearchAPIRequestModel()
    private var dataStore: MoviesDataStore = MoviesAPIDataStore()
    var moreDataLoaded = Detectable<Bool>(false)
    //MARK:- Initializer
    public init(delegate: ViewModelDelegate, dataStore: MoviesDataStore = MoviesAPIDataStore()) {
        super.init()
        self.delegate = delegate
        self.dataStore = dataStore
    }
    
    func search(with query:String) {
        currentQuery = query.trim()
//        let request = SearchAPIRequestModel()
        dataStore.searchMovies(with: query, page: "1", request: request) { [weak self] (result) in
            guard let this = self else{
                return
            }
            switch result {
                case .success(let data):
                    this.response = data
                    this.currentPage = data.page
                    this.makeReady()
                
            case .failure(let error):
                this.throwError(with: error)
            }
        }
    }
    
    func loadMore() {
        guard hasMore() else {
            return
        }
        currentPage += 1
        let pageString = "\(currentPage)"
        dataStore.searchMovies(with: currentQuery ?? "", page: pageString, request: request) { [weak self] (result) in
            
            guard let this = self else{
                return
            }
            switch result {
                case .success(let data):
                    this.response?.movies.append(contentsOf: data.movies)
                    this.currentPage = data.page
                    this.moreDataLoaded.value = true
                
            case .failure(let error):
                this.throwError(with: error)
            }
        }
        
    }
    
    func hasMore() -> Bool {
        let page = currentPage + 1
        guard page <= getTotalPages() else { return false}
        return true
    }
    
    func getNumberOfResults() -> Int {
        return response?.movies.count ?? 0
    }
    
    func getTotalPages() -> Int {
        return response?.totalPages ?? 0
    }
    
    func movieCellViewModel(at row: Int) -> MovieCellViewModeling? {
        
        guard let movies = response?.movies else {
            return nil
        }
        return MovieCellViewModel(movie: movies[row])
    }
    
    func saveSearchHistory(searchText: String?) {
        guard let search:String = searchText, !search.isEmpty else { return }
        let searchHistory = UserDefaults.Settings.SearchHistory.array()
        if(searchHistory.count >= 10) {
            guard let historyText = searchHistory.first , !historyText.isEmpty else { return }
            UserDefaults.Settings.SearchHistory.remove(historyText)
        }
        
        if searchHistory.contains(search) {
            UserDefaults.Settings.SearchHistory.remove(search)
        }
        UserDefaults.Settings.SearchHistory.append(search)
    }
    
    func getSearchHistory() -> [String] {
        return UserDefaults.Settings.SearchHistory.array().reversed()
    }
}
