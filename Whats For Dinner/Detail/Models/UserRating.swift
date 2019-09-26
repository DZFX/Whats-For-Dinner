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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            aggregateRating = try container.decodeIfPresent(String.self, forKey: .aggregateRating)
        } catch DecodingError.typeMismatch { // Workaround as API sometimes returns some values as numbers instead of Strings
            if let intRating = try container.decodeIfPresent(Int.self, forKey: .aggregateRating) {
                aggregateRating = "\(intRating)"
            } else {
                aggregateRating = nil
            }
        }
        
        ratingText = try container.decodeIfPresent(String.self, forKey: .ratingText)
        ratingColor = try container.decodeIfPresent(String.self, forKey: .ratingColor)
        
        do {
            votes = try container.decodeIfPresent(String.self, forKey: .votes)
        } catch DecodingError.typeMismatch {
            if let intVotes = try container.decodeIfPresent(Int.self, forKey: .votes) {
                votes = "\(intVotes)"
            } else {
                votes = nil
            }
        }
    }
}

