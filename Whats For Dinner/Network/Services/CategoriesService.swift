//
//  CategoriesService.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

enum CategoriesService: ServiceProtocol {
    case getCategories
    
    var path: String {
        switch self {
        case .getCategories:
            return "/categories"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getCategories:
            return .requestPlain
        }
    }
}
