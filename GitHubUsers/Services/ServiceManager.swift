//
//  Service.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay Gupta. All rights reserved.
//

import Foundation

public typealias Prarameter = [String: String]
public typealias Response = [String: Any]


class ServiceManager {
    
    static func searchUsers<T: Decodable>(search: String, page: Int, type: T.Type, completion: @escaping (Result<T>) -> Void) {
        let url: String = URLConstants.Git.search
        let param = [
            "q": search,
            "page": String(describing: page),
            "sort": "score"
        ]
        
        WaitingIndicator.showWaiting()
        Service.request(url, parameters: param, type: type) { result in
            WaitingIndicator.stopWaiting()
            switch result {
            case .success(let object):
                completion(Result.success(object))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    static func fetchUserProfile<T: Decodable>(url: String, type: T.Type, completion: @escaping (T?) -> Void) {
        var gitUserProfile: GitUserProfile?
        WaitingIndicator.showWaiting()
        Service.request(url, parameters: nil, type: type) { result in
            WaitingIndicator.stopWaiting()
            switch result {
            case .success(let gitUserDetails):
                gitUserProfile = gitUserDetails as? GitUserProfile
                WaitingIndicator.showWaiting()
                self.fetchGitRepos(url: gitUserProfile?.repos_url ?? "", type: GitUserRepoList.self, completion: { gitUserRepos in
                    WaitingIndicator.stopWaiting()
                    gitUserProfile?.repo = gitUserRepos?.gitRepo
                    completion(gitUserProfile as? T)
                })
                completion(gitUserProfile as? T)
            case .failure(let error):
                print("Error..\(error) in \(url) response")
                completion(gitUserProfile as? T)
            }
        }
    }
    
    static private func fetchGitRepos<T: Decodable>(url: String, type: T.Type, completion: @escaping (T?) -> Void) {
        Service.request(url, parameters: nil, type: type) { result in
            switch result {
            case .success(let gitUserRepos):
                completion(gitUserRepos)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    static func fetchUserRepos<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T>) -> Void) {
        Service.request(url, parameters: nil, type: type) { result in
            switch result {
            case .success(let object):
                completion(Result.success(object))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    static func getRepoData<T: Decodable>(searchText: String, type: T.Type, completion: @escaping (Result<T>) -> Void) {
        let url: String = URLConstants.Git.gmap
        let param = Utility.setSearchParm(repo: searchText)
        
        Service.request(url, parameters: param, type: type) { result in
            switch result {
            case .success(let object):
                completion(Result.success(object))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
