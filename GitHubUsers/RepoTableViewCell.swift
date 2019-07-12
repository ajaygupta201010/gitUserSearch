//
//  RepoTableViewCell.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 12/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDesriptionLabel: UILabel!
    
    @IBOutlet weak var watchCountLabel: UILabel!
    @IBOutlet weak var viewRepoButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func viewRepoButtonClicked(_ sender: Any) {
        guard let url = URL(string: "https://github.com/torvalds") else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
