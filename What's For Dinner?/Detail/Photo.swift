//
//  Photo.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let id: String?
    let url: String?
    let thumbURL: String?
    let user: User?
    let resID: Int?
    let caption: String?
    let timestamp: Int?
    let friendlyTime: String?
    let width: Int?
    let height: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case thumbURL = "thumb_url"
        case user
        case resID = "res_id"
        case caption
        case timestamp
        case friendlyTime = "friendly_time"
        case width
        case height
    }
}
