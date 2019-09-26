//
//  HomeViewModel.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation
import CoreLocation

class RestaurantsViewModel: NSObject {
    
    // MARK: - Properties
    private var locationManager = CLLocationManager()
    private var latitude = 37.773972
    private var longitude = -122.431297
    private var gotLocationHandler: (() -> Void)?
    var category: Category?
    
    // MARK: - Location
    func attemptGetUserLocation(completion: @escaping () -> Void) {
        gotLocationHandler = completion
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Network
    func getNearbyRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        if let category = self.category {
            APIClient.Restaurants.getRestaurants(from: category, latitude: latitude, longitude: longitude) { (response) in
                completion(response)
            }
        } else {
            APIClient.Restaurants.searchFromCoordinates(latitude: latitude, longitude: longitude) { (response) in
                completion(response)
            }
        }
    }
    
    func getTrendingRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        APIClient.Restaurants.retrieveTrendingFromCoordinates(latitude: latitude, longitude: longitude) { (response) in
            completion(response)
        }
    }
}

extension RestaurantsViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Fallback to default location: \(error)")
        gotLocationHandler?()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        gotLocationHandler?()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            gotLocationHandler?()
        }
    }
}
