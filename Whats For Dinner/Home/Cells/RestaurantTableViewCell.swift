//
//  RestaurantTableViewCell.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var perksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.cornerRadius = 2.5
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = UIImage(named: "Placeholder")
    }
    
    func configure(with restaurant: Restaurant) {
        if let thumbURLString = restaurant.thumb,
            let url = URL(string: thumbURLString) {
            thumbImageView.kf.setImage(with: url)
        }
        restaurantNameLabel.text = restaurant.name
        ratingLabel.text = restaurant.userRating?.aggregateRating
        cuisineLabel.text = restaurant.cuisines
        statusLabel.text = restaurant.timings
        perksLabel.text = getPerks(from: restaurant)
    }
    
    private func getPerks(from restaurant: Restaurant) -> String {
        var statuses = [String]()
        
        if restaurant.hasOnlineDelivery ?? false { statuses.append("Online Delivery") }
        if restaurant.hasTableBooking ?? false { statuses.append("Takes Reservations") }
        if restaurant.isDeliveringNow ?? false { statuses.append("Delivery Service") }
        
        return statuses.joined(separator: " - ")
    }

}
