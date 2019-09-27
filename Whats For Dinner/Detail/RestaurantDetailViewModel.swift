//
//  RestaurantDetailViewModel.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

class RestaurantDetailViewModel {
    
    let restaurant: Restaurant
    
    let sectionTitles: [String] = {
        return [
            "Hours & Contact",
            "Rating",
            "Reviews & Media",
            "Other Info"
        ]
    }()
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    var restaurantName: String {
        return restaurant.name ?? "N/A"
    }
    
    var cuisine: String {
        return restaurant.cuisines ?? ""
    }
    
    var featuredPhoto: String {
        return restaurant.featuredImage ?? ""
    }
    
    var hours: String {
        return restaurant.timings ?? ""
    }
    
    var phoneNumbers: String {
        return restaurant.phoneNumbers ?? "N/A"
    }
    
    var address: String {
        return restaurant.location?.address ?? ""
    }
    
    var ratingStatement: String {
        var ratingStringArray = [String]()
        
        if let text = restaurant.userRating?.ratingText { ratingStringArray.append(text) }
        if let score = restaurant.userRating?.aggregateRating { ratingStringArray.append(score) }
        if let votes = restaurant.userRating?.votes { ratingStringArray.append("\(votes) votes") }
        
        return ratingStringArray.joined(separator: " - ")
    }
    
    var hasReviews: Bool {
        return (restaurant.allReviewsCount ?? 0) > 0 ? true : false
    }
    
    var viewReviewsCounter: String {
        if hasReviews {
            return "View \(restaurant.allReviews?.count ?? 0) reviews"
        }
        return "No reviews yet"
    }
    
    var reviews: [Review] {
        return restaurant.allReviews ?? []
    }
    
    var hasPhotos: Bool {
        return (restaurant.photoCount ?? 0) > 0 ? true : false
    }
    
    var viewPhotosCounter: String {
        if hasPhotos {
            return "View \(restaurant.photos?.count ?? 0) photos"
        }
        return "No photos uploaded"
    }
    
    var photos: [Photo] {
        return restaurant.photos ?? []
    }
    
    var numberOfHighlights: Int {
        return restaurant.highlights?.count ?? 0
    }
    
    func title(from section: Int) -> String {
        return sectionTitles[section]
    }
    
    func highlight(row: Int) -> String {
        return restaurant.highlights?[row] ?? ""
    }
    
}
