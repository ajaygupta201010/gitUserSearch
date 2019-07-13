//
//  GitRepoCellModel.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay Gupta. All rights reserved.
//

import Foundation

struct GitRepoCellModel {
    var repoName: String
    var stars: Int
    var forks: Int
    var urlStr: String
    var repoDetails: String
    
    init(repoName: String, urlStr: String, stars: Int, forks: Int, repoDetails: String) {
        self.repoName = repoName
        self.stars = stars
        self.forks = forks
        self.urlStr = urlStr
        self.repoDetails = repoDetails
    }
}
