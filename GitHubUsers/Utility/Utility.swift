//
//  Utility.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay Gupta. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    class func setSearchParm(repo: String) -> Prarameter {
        return [
            "q": repo,
            "sort": "star",
            "order": "desc",
        ]
    }
    
    class func setParams(parms: Dictionary<String, String>) -> String {
        var parts: [String] = []
        for (key, value) in parms {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
    class func maskCircle(view: UIImageView, anyImage: UIImage) {
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        
        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        view.image = anyImage
    }
}
