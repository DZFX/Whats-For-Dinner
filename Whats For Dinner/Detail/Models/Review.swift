//
//  Review.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

struct Review: Decodable {
    let rating: Double?
    let reviewText: String?
    let id: Int?
    let ratingColor: String?
    let reviewTimeFriendly: String?
    let ratingText: String?
    let timestamp: Int?
    let likes: Int?
    let user: User?
    let commentsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case rating
        case reviewText = "review_text"
        case id
        case ratingColor = "rating_color"
        case reviewTimeFriendly = "review_time_friendly"
        case ratingText = "rating_text"
        case timestamp
        case likes
        case user
        case commentsCount = "comments_count"
    }
}

struct User: Decodable {
    let name: String?
    let foodieLevel: String?
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case foodieLevel = "foodie_level"
        case profileImage = "profile_image"
    }
}
