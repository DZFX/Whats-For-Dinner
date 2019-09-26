//
//  RestaurantDetailHeader.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class RestaurantDetailHeader: UIView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var cuisineLabel: UILabel!

    var name: String {
        set {
            nameLabel.text = newValue
        }
        
        get {
            return nameLabel.text ?? ""
        }
    }
    
    var cuisine: String {
        set {
            cuisineLabel.text = newValue
        }
        
        get {
            return cuisineLabel.text ?? ""
        }
    }
    
    func setImageURLString(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imageView.kf.setImage(with: url)
    }
}
