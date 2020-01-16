//
//  MovieCell.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 07/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    private let movieTitleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let movieOverviewLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let movieImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(movieOverviewLabel)
        movieImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        movieTitleLabel.anchor(top: topAnchor, left: movieImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        movieOverviewLabel.anchor(top: movieTitleLabel.bottomAnchor, left: movieImageView
            .rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(movie: MovieCellViewModeling) {
        movieTitleLabel.text = movie.title
        movieOverviewLabel.text = movie.overView
        movieImageView.loadImage(withUrlString: movie.posterPath, placeholderImage: "emptyImage".img())
    }

}
