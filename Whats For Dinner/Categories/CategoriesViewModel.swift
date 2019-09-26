//
//  CategoriesViewModel.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

class CategoriesViewModel {
    
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        APIClient.Common.getCategories { (response) in
            completion(response)
        }
    }
}
