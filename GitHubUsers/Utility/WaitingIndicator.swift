//
//  WaitingIndicator.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 13/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import Foundation
import UIKit

class WaitingIndicator: NSObject {
    
    static private var vSpinner : UIView?
    
    class func showWaiting(within view: UIView? = nil) {
        DispatchQueue.main.async {
            guard let vc = Utility.getPresentVC() else { return }
            let onView: UIView = view ?? vc.view
            let spinnerView = UIView.init(frame: onView.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            ai.startAnimating()
            ai.center = spinnerView.center
            
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            WaitingIndicator.vSpinner = spinnerView
        }
    }
    
    class func stopWaiting() {
        DispatchQueue.main.async {
            WaitingIndicator.vSpinner?.removeFromSuperview()
            WaitingIndicator.vSpinner = nil
        }
    }
}
