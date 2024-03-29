//
//  ServiceProtocol.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

typealias Headers = [String: String]

protocol ServiceProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}

extension ServiceProtocol {
    var baseURL: URL {
        return URL(string: "https://developers.zomato.com/api/v2.1")!
    }
    
    var headers: Headers? {
        return ["user-key" : "75b8aa16761c73a97d0785463cadaf5a"]
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
