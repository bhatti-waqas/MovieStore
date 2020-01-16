//
//  MovieCell.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

class MovieCell_v1: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    public func bind(movie: MovieCellViewModeling) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overView
        posterImageView?.loadImage(withUrlString: movie.posterPath, placeholderImage: "emptyImage".img())
    }
}
