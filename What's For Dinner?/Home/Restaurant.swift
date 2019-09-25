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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        location = try container.decodeIfPresent(Location.self, forKey: .location)
        thumb = try container.decodeIfPresent(String.self, forKey: .thumb)
        featuredImage = try container.decodeIfPresent(String.self, forKey: .featuredImage)
        userRating = try container.decodeIfPresent(UserRating.self, forKey: .userRating)
        hasOnlineDelivery = try container.decodeIfPresent(Bool.self, forKey: .hasOnlineDelivery)
        isDeliveringNow = try container.decodeIfPresent(Bool.self, forKey: .isDeliveringNow)
        hasTableBooking = try container.decodeIfPresent(Bool.self, forKey: .hasTableBooking)
        cuisines = try container.decodeIfPresent(String.self, forKey: .cuisines)
        allReviewsCount = try container.decodeIfPresent(Int.self, forKey: .allReviewsCount)
        phoneNumbers = try container.decodeIfPresent(String.self, forKey: .phoneNumbers)
        timings = try container.decodeIfPresent(String.self, forKey: .timings)
        photoCount = try container.decodeIfPresent(Int.self, forKey: .photoCount)
        
        if let photoContainers = try container.decodeIfPresent([PhotoContainer].self, forKey: .photos) {
            photos = photoContainers.compactMap { $0.photo }
        } else {
            photos = nil
        }
        
        if let reviewContainers = try container.decodeIfPresent([ReviewContainer].self, forKey: .allReviews) {
            allReviews = reviewContainers.compactMap { $0.review}
        } else {
            allReviews = nil
        }
    }
}

struct PhotoContainer: Decodable {
    let photo: Photo
}

struct ReviewContainer: Decodable {
    let review: Review
}
