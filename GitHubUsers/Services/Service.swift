
//  Service.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay Gupta. All rights reserved.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case failure(ServiceErrors)
}

// makes server calls
class Service {
    
    static func request<T: Decodable>(_ url: String, parameters: Prarameter? = nil, type model: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        guard var components = URLComponents(string: url) else {
            print("ERROR: ..Incorrect URL..")
            completion(Result.failure(ServiceErrors.invalidUrl))
            return
        }
        components.queryItems = parameters?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        print("urls is: \(components.url!)")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let resultData = data,                      // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                error == nil else {                           // was there no error, otherwise ...
                    completion(Result.failure(ServiceErrors.unknown))
                    return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(model, from: resultData)
                completion(Result.success(responseModel))
            } catch {
                print("cant decode to git response: \(error.localizedDescription)")
                completion(Result.failure(ServiceErrors.invalidResponseJson))
            }
        }
        task.resume()
    }
}
