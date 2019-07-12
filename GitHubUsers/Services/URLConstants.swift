//
//  URLConstants.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay Gupta. All rights reserved.
//

import Foundation

struct URLConstants {
    static let git = "https://api.github.com/search/repositories"
    static let gmap = "https://www.google.com/search/"
    static func searchURL(for user: String, page: Int = 1) -> String { 
        var baseUrl = "https://api.github.com/search/users"
        let component = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        baseUrl = baseUrl + "q=\(for)&page=1
    }
}
