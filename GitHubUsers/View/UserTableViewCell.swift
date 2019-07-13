//
//  UserTableViewCell.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 12/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    func configUI(avatarUrl: String?, name: String?, score: Double?) {
        userImageView.image = #imageLiteral(resourceName: "userImage")
        self.fetchAvatar(urlStr: avatarUrl ?? "")
        userNameLabel.text = name
        scoreLabel.text = String(describing: score ?? 0)
    }
    
    private func fetchAvatar(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                if let img = UIImage(data: data) {
                    Utility.maskCircle(view: self.userImageView, anyImage: img)
                }
            }
        }
    }

}
