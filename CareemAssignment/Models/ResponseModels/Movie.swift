//
//  Movie.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

enum ShowImageSize:String {
    case w92 = "w92"
    case w185 = "w185"
    case w500 = "w500"
    case w780 = "w780"
}

class Movie: Decodable {
    var id:Int = -1
    var video:Bool = false
    var posterPath:String?
    var title:String?
    var overview:String?
    
    enum CodingKeys : String, CodingKey {
        case id
        case video
        case posterPath = "poster_path"
        case title
        case overview
    }
    
    func fullposterPath(size: ShowImageSize = .w92) -> String? {
        guard let posterImagePath = posterPath else {
            return nil
        }
        
        return APIURLs.imageBaseURL + size.rawValue + posterImagePath
    }
}
