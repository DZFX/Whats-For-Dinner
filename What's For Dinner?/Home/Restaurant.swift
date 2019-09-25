//
//  Restaurant.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
    let id: String?
    let name: String?
    let url: String?
    let location: Location?
    let thumb: String?
    let featuredImage: String?
    let userRating: UserRating?
    let hasOnlineDelivery: Bool?
    let isDeliveringNow: Bool?
    let hasTableBooking: Bool?
    let cuisines: String?
    let allReviewsCount: Int?
    let phoneNumbers: String?
    let timings: String?
    let photoCount: Int?
    let photos: [Photo]?
    let allReviews: [Review]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case location
        case thumb
        case featuredImage = "featured_image"
        case userRating = "user_rating"
        case hasOnlineDelivery = "has_online_delivery"
        case isDeliveringNow = "is_delivering_now"
        case hasTableBooking = "has_table_booking"
        case cuisines
        case allReviewsCount = "all_reviews_count"
        case phoneNumbers = "phone_numbers"
        case timings
        case photoCount = "photo_count"
        case photos
        case allReviews = "all_reviews"
    }
}

