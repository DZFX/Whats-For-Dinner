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
    
    var path: String {
        switch self {
        case .searchNearby:
            return "/search"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .searchNearby(latitude, longitude):
            let parameters = [
                "lat": latitude,
                "lon": longitude,
            ]
            return .requestParameters(parameters)
        }
    }
}
