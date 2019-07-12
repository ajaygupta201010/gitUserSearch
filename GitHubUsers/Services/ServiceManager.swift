//
//  Service.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay Gupta. All rights reserved.
//

import Foundation

typealias Prarameter = [String: String]
typealias Response = [String: Any]


class ServiceManager {
    
    static func getRepoData(searchText: String, completion: @escaping (GitResponseModel?) -> Void) {
        let url: String = URLConstants.git
        let param = Utility.setSearchParm(repo: searchText)
        
        Service.sendRequest(url, parameters: param) { data, error in
            if let resultData = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(GitResponseModel.self, from: resultData)
                    completion(responseModel)
                } catch {
                    print("cant decode to git response: \(error.localizedDescription)")
                    completion(nil)
                }
            }
            //            switch result {
            //            case .success(let data):
            //                do {
            //                    let jsonDecoder = JSONDecoder()
            //                    let responseModel = try jsonDecoder.decode(GitRepositoryModel.self, from: data)
            //                    print("responseModel: \(responseModel.total_count)")
            //                } catch {
            //                    print("cant decode to git response")
            //                }
            //
            //            case .failure(let error): break
            //            }
        }
    }
    
    
    static func getRepoContent(url: String, completion: @escaping (String?) -> Void) {
        Service.sendRequest(url, completion: { data, error in
            if let resultData = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: resultData, options: .mutableContainers) as? [String: Any] {
                        if let dependency = JSON(json)["content"].string {
                            let str = dependency.base64Decoded()
                            completion(str)
                        }
                    }
                } catch {
                    print("cant decode to git response: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }
}
