//
//  UserRating.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

struct UserRating: Decodable {
    let aggregateRating: String?
    let ratingText: String?
    let ratingColor: String?
    let votes: String?
    
    enum CodingKeys: String, CodingKey {
        case aggregateRating = "aggregate_rating"
        case ratingText = "rating_text"
        case ratingColor = "rating_color"
        case votes
    }
}

