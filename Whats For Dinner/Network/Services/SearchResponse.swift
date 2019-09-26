//
//  SearchResponse.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let restaurants: [Restaurant]?
    
    enum CodingKeys: String, CodingKey {
        case restaurants
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let restaurantContainers = try container.decodeIfPresent([RestaurantContainer].self, forKey: .restaurants) {
            restaurants = restaurantContainers.compactMap { $0.restaurant }
        } else {
            restaurants = nil
        }
    }
}

private struct RestaurantContainer: Decodable {
    let restaurant: Restaurant?
}
