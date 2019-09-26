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
        APIClient.Restaurants.searchFromCurrentLocation { (response) in
            completion(response)
        }
    }
}