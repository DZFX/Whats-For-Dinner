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
    let highlights: [String]?
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
        case highlights
        case photoCount = "photo_count"
        case photos
        case allReviews = "all_reviews"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            id = try container.decodeIfPresent(String.self, forKey: .id)
        } catch DecodingError.typeMismatch { // Workaround as API returns some IDs as numbers instead of Strings in case of a 'trending' search
            if let intID = try container.decodeIfPresent(Int.self, forKey: .id) {
                id = "\(intID)"
            } else {
                id = nil
            }
        }
        
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        location = try container.decodeIfPresent(Location.self, forKey: .location)
        thumb = try container.decodeIfPresent(String.self, forKey: .thumb)
        featuredImage = try container.decodeIfPresent(String.self, forKey: .featuredImage)
        userRating = try container.decodeIfPresent(UserRating.self, forKey: .userRating)
        hasOnlineDelivery = (try container.decodeIfPresent(Int.self, forKey: .hasOnlineDelivery) ?? 0) == 1 ? true : false
        isDeliveringNow = (try container.decodeIfPresent(Int.self, forKey: .isDeliveringNow) ?? 0) == 1 ? true : false
        hasTableBooking = (try container.decodeIfPresent(Int.self, forKey: .hasTableBooking) ?? 0) == 1 ? true : false
        cuisines = try container.decodeIfPresent(String.self, forKey: .cuisines)
        allReviewsCount = try container.decodeIfPresent(Int.self, forKey: .allReviewsCount)
        phoneNumbers = try container.decodeIfPresent(String.self, forKey: .phoneNumbers)
        timings = try container.decodeIfPresent(String.self, forKey: .timings)
        highlights = try container.decodeIfPresent([String].self, forKey: .highlights)
        photoCount = try container.decodeIfPresent(Int.self, forKey: .photoCount)
        
        if let photoContainers = try container.decodeIfPresent([PhotoContainer].self, forKey: .photos) {
            photos = photoContainers.compactMap { $0.photo }
        } else {
            photos = nil
        }
        
        if let allReviews = try container.decodeIfPresent(AllReviews.self, forKey: .allReviews) {
            self.allReviews = allReviews.reviews?.compactMap { $0.review}
        } else {
            self.allReviews = nil
        }
    }
}

struct PhotoContainer: Decodable {
    let photo: Photo
}

struct AllReviews: Decodable {
    let reviews: [ReviewContainer]?
}

struct ReviewContainer: Decodable {
    let review: Review
}
