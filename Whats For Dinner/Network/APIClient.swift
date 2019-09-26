//
//  APIClient.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

class APIClient {
    
    static let shared = APIClient()
    
    private init() {}
    
    private let sessionProvider = URLSessionProvider()
    
    struct Common {
        static func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
            APIClient.shared.sessionProvider.request(type: CategoriesResponse.self,
                                                     service: CategoriesService.getCategories) { (response) in
                                                        switch response {
                                                        case let .failure(error):
                                                            completion(.failure(error))
                                                        case let.success(categories):
                                                            completion(.success(categories.categories ?? []))
                                                        }
            }
        }
    }
    
    struct Restaurants {
        
        static func searchFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (Result<[Restaurant], Error>) -> Void) {
            APIClient.shared.sessionProvider.request(type: SearchResponse.self,
                                                     service: SearchService.searchNearby(latitude: latitude, longitude: longitude)) { (response) in
                                                        switch response {
                                                        case let .failure(error):
                                                            completion(.failure(error))
                                                        case let .success(restaurants):
                                                            completion(.success(restaurants.restaurants ?? []))
                                                        }
            }
        }
        
        static func retrieveTrendingFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (Result<[Restaurant], Error>) -> Void) {
            APIClient.shared.sessionProvider.request(type: SearchResponse.self,
                                                     service: SearchService.trending(latitude: 37.3229978, longitude: -122.0321823)) { (response) in
                                                        switch response {
                                                        case let .failure(error):
                                                            completion(.failure(error))
                                                        case let .success(restaurants):
                                                            completion(.success(restaurants.restaurants ?? []))
                                                        }
            }
        }
    }
}
