//
//  ServiceErrors.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 12/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import Foundation

enum ServiceErrors: Error {
    case invalidUrl
    case invalidResponseJson
    case unknown
}
