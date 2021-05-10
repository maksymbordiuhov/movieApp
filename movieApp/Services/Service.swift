//
//  Service.swift
//  movieApp
//
//  Created by Maksym Bordyugov on 08.05.2021.
//  Copyright © 2021 Maksym Bordyugov. All rights reserved.
//

import Foundation

class Service {

    // MARK: - Utility
    
    func createApiUrl(with path:String, queryItems: [URLQueryItem]) -> URL? {
        var query = [
            URLQueryItem(name: "api_key", value: Constants.api().key),
            URLQueryItem(name: "language", value: Constants.api().language)
        ]
        query.append(contentsOf: queryItems)
        var urlComponents = URLComponents(string: "\(Constants.api().url)\(path)")
        urlComponents?.queryItems = query
        return urlComponents?.url
    }
}
