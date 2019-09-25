//
//  Location.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

struct Location: Decodable {
    let address: String?
    let locality: String?
    let city: String?
    let cityID: Int?
    let latitude: String?
    let longitude: String?
    let zipcode: String?
    let countryID: Int?
    let localityVerbose: String?
    
    enum CodingKeys: String, CodingKey {
        case address
        case locality
        case city
        case cityID = "city_id"
        case latitude
        case longitude
        case zipcode
        case countryID = "country_id"
        case localityVerbose = "locality_verbose"
    }
}


