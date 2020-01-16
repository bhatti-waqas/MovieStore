//
//  UIImageView.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

import UIKit
import AlamofireImage

protocol ImageLazyLoading {
    
    func loadImage(withUrlString urlString:String?,placeholderImage placeholder:UIImage?)
}

extension UIImageView:ImageLazyLoading {
    
    func loadImage(withUrlString urlString: String?, placeholderImage placeholder: UIImage?) {
        
        image = placeholder
        guard
            let _urlString = urlString,
            let imageURL = URL(string:_urlString)
            else { return }
        
        af_setImage(withURL: imageURL, placeholderImage: placeholder,imageTransition: .crossDissolve(0.2))
    }
    
}
