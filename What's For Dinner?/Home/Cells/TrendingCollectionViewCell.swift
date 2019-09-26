//
//  TrendingCollectionViewCell.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.cornerRadius = 1.5
        contentView.layer.cornerRadius = 2.0
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
//        contentView.layer.shadowOpacity = 0.5
//        contentView.layer.shadowRadius = 3.0
//        contentView.layer.shadowOffset = CGSize(width: 3.0, height: 0.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = UIImage(named: "Placeholder")
    }
    
    func configure(with restaurant: Restaurant) {
        if let url = URL(string: restaurant.thumb ?? ""),
            let data = try? Data(contentsOf: url) {
            thumbImageView.image = UIImage(data: data)
        }
        restaurantNameLabel.text = restaurant.name
        ratingLabel.text = restaurant.userRating?.aggregateRating
        cuisineLabel.text = restaurant.cuisines
    }
}
