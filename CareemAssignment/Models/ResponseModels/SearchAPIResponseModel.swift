//
//  SearchResponseAPIModel.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

class SearchAPIResponseModel: Decodable {
    
    var page:Int = -1
    var totalResults:Int = -1
    var totalPages:Int = -1
    var movies:[Movie] = []
    
    enum CodingKeys : String, CodingKey {
        
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
    
}
