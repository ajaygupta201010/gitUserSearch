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
        view.image = anyImage
    }
    
    class func getPresentVC() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    class func convertDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date_ = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if let dt = date_ {
            return dateFormatter.string(from: dt)
        }
        return ""
    }
    
    class func shareDetailsWithOtherApps(viewController: UIViewController, url: URL? = nil,
                                         text: String? = nil, image: UIImage? = nil) {
        
        var objectsToShare = [Any]()
        
        if let url = url {
            objectsToShare.append(url)
        }
        
        if let text = text {
            objectsToShare.append(text)
        }
        if let image = image {
            objectsToShare.append(image)
        }
        
        let activityController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityController.popoverPresentationController?.sourceView = viewController.view
        
        DispatchQueue.main.async {
            viewController.present(activityController, animated: true, completion: nil)
        }
    }
}

extension UISearchBar {
    var textField: UITextField? {
        return subviews.first?.subviews.compactMap { $0 as? UITextField }.first
    }
}
