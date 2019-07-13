//
//  URLConstants.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay Gupta. All rights reserved.
//

import Foundation

struct URLConstants {
    
    struct Git {
        static let repo = "https://api.github.com/search/repositories"
        static let gmap = "https://www.google.com/search/"
        static let search = "https://api.github.com/search/users"
        static let userDetails = "https://api.github.com/users/"
    }
    
//    static func searchURL(for user: String, page: Int = 1) -> URL? {
//        guard let baseUrl = URL(string: "https://api.github.com/search/users") else {
//            return nil
//        }
//        var urlComponent = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
//        urlComponent?.queryItems = [
//            URLQueryItem(name: "q", value: user),
//            URLQueryItem(name: "page", value: String(describing: page))
//        ]
//        return urlComponent?.url
//    }
}
