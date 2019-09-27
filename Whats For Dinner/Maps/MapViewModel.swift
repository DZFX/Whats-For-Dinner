//
//  MapViewModel.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel {
    
    // MARK: - Properties
    var restaurantPins = [RestaurantAnnotation]()
    
    func setupAnnotations(restaurants: [Restaurant]) {
        restaurantPins = restaurants.compactMap { (restaurant) -> RestaurantAnnotation? in
            return RestaurantAnnotation(restaurant: restaurant)
        }
    }
}
