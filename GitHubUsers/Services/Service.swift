
//  Service.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay Gupta. All rights reserved.
//

import Foundation
import UIKit

//enum Result<Data, Error> {
//    case success(Data)
//    case failure(Error)
//}

// makes server calls
class Service {
    
    static func sendRequest(_ url: String, parameters: Prarameter? = nil, completion: @escaping (Data?, Error?) -> Void) {
        var components = URLComponents(string: url)!
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
                    completion(nil, error)
                    return
            }
            completion(resultData, nil)
        }
        task.resume()
    }
}
