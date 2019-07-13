//
//  GitUserProfile.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import Foundation

struct GitUserProfile: Codable {
	let avatar_url : String?
	let html_url : String?
	let name : String?
    let company : String?
	let followers : Int?
	let updated_at : String?
    let repos_url : String?
    var repo : [GitUserRepo]?

	enum CodingKeys: String, CodingKey {
		case avatar_url = "avatar_url"
		case html_url = "html_url"
        case name = "name"
        case company = "company"
		case followers = "followers"
		case updated_at = "updated_at"
        case repos_url = "repos_url"
        case repo
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url)
		html_url = try values.decodeIfPresent(String.self, forKey: .html_url)
		name = try values.decodeIfPresent(String.self, forKey: .name)
        company = try values.decodeIfPresent(String.self, forKey: .company)
		followers = try values.decodeIfPresent(Int.self, forKey: .followers)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        repos_url = try values.decodeIfPresent(String.self, forKey: .repos_url)
	}
}
