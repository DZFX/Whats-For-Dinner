//
//  SearchService.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

enum SearchService: ServiceProtocol {
    
    case searchNearby(latitude: Double, longitude: Double)
    case trending(latitude: Double, longitude: Double)
    case byCategory(categoryID: Int, latitude: Double, longitude: Double)
    
    var path: String {
        switch self {
        case .searchNearby, .trending, .byCategory:
            return "/search"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .searchNearby(latitude, longitude):
            let parameters: [String : Any] = [
                "lat": latitude,
                "lon": longitude,
                "radius": 1000,
                "sort": "real_distance",
                "order": "asc"
            ]
            return .requestParameters(parameters)
            
        case let .trending(latitude, longitude):
            let parameters: [String: Any] = [
                "lat": latitude,
                "lon": longitude,
                "radius": "3000",
                "collection_id": 1,
                "sort": "rating",
                "order": "desc"
            ]
            return .requestParameters(parameters)
            
        case let .byCategory(categoryID, latitude, longitude):
            let parameters: [String: Any] = [
                "category": categoryID,
                "lat": latitude,
                "lon": longitude,
                "sort": "rating",
                "order": "desc"
            ]
            return .requestParameters(parameters)
        }
    }
}
