//
//  RestaurantTableViewCell.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var perksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with restaurant: Restaurant) {
        if let url = URL(string: restaurant.thumb ?? ""),
            let data = try? Data(contentsOf: url) {
            thumbImageView.image = UIImage(data: data)
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
