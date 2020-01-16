//
//  MoviesAPIRequestModel.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

struct SearchAPIRequestModel: Codable {
    
    var apiKey:String = APPKeys.APIKeys.themoviedb
    var query:String = ""
    var page:Int = -1
    private enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case query
        case page
    }
}
