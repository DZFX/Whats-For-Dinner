//
//  URLRequestExtension.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(service: ServiceProtocol) {
        let urlComponents = URLComponents(service: service)
        
        self.init(url: urlComponents.url!)
        
        httpMethod = service.method.rawValue
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .json else { return }
        httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }
}
