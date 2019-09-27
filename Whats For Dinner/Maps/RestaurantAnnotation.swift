//
//  RestaurantAnnotation.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/27/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    var restaurant: Restaurant
    
    var coordinate: CLLocationCoordinate2D {
        guard
            let latitudeString = restaurant.location?.latitude, let latitude = Double(latitudeString),
            let longitudeString = restaurant.location?.longitude, let longitude = Double(longitudeString)
            else { return CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0) }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        return restaurant.name
    }
    
    var subtitle: String? {
        return restaurant.location?.address
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
}
