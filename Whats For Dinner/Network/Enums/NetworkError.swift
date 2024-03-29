//
//  NetworkError.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

enum NetworkError: Error {
    case unknown
    case noJSONData
    case error(Error)
}
