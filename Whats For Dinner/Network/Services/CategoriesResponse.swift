//
//  CategoriesResponse.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

struct CategoriesResponse: Decodable {
    let categories: [Category]?
    
    enum CodingKeys: String, CodingKey {
        case categories
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let categoryContainers = try container.decodeIfPresent([CategoryContainer].self, forKey: .categories) {
            categories = categoryContainers.compactMap { $0.categories }
        } else {
            categories = nil
        }
    }
}

private struct CategoryContainer: Decodable {
    let categories: Category?
}
