//
//  GitUserRepo.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import Foundation

struct GitUserRepoList : Codable {
    let gitRepo : [GitUserRepo]?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements = [GitUserRepo]()
        if let count = container.count {
            elements.reserveCapacity(count)
        }
        
        while !container.isAtEnd {
            let element = try container.decode(GitUserRepo.self)
            elements.append(element)
        }
        self.gitRepo = elements
    }
}


struct GitUserRepo : Codable {
	let id : Int?
	let name : String?
	let full_name : String?
	let html_url : String?
	let description : String?
    let forks : Int?
    
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
		case full_name = "full_name"
		case html_url = "html_url"
		case description = "description"
		case forks = "forks"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
		html_url = try values.decodeIfPresent(String.self, forKey: .html_url)
		description = try values.decodeIfPresent(String.self, forKey: .description)
        forks = try values.decodeIfPresent(Int.self, forKey: .forks)
	}

}
