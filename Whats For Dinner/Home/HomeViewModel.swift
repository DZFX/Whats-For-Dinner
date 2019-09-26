//
//  HomeViewModel.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    func getNearbyRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        APIClient.Restaurants.searchFromCoordinates(latitude: 37.3229978, longitude: -122.0321823) { (response) in
            completion(response)
        }
    }
    
    func getTrendingRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        APIClient.Restaurants.retrieveTrendingFromCoordinates(latitude: 37.3229978, longitude: -122.0321823) { (response) in
            completion(response)
        }
    }
}
