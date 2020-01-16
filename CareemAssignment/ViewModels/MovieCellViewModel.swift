//
//  MovieCellViewModel.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit


protocol MovieCellViewModeling {
    
    var title :String { get }
    var overView :String { get }
    var posterPath : String? { get }
    
    
}

struct MovieCellViewModel:MovieCellViewModeling{
    
    fileprivate let movie:Movie!
    init(movie: Movie) {
        self.movie = movie
    }
    var title:String {
        guard let title = movie.title, !title.isEmpty else {
            return "No Title"
        }
        return title
    }
    var overView:String {
        guard let overview = movie.overview, !overview.isEmpty else {
            return "No Overview"
        }
        return overview
    }
    var posterPath: String? { return movie.fullposterPath()}
}



