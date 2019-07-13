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
    
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var viewRepoButton: UIButton!

    
    private var repoUrl: String = ""

    @IBAction func viewRepoButtonClicked(_ sender: Any) {
        guard let url = URL(string: repoUrl) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func configUI(repo: GitUserRepo) {
        repoNameLabel.text = repo.full_name
        repoDesriptionLabel.text = repo.description
        forks.text = String(describing: repo.forks ?? 0)
        repoUrl = repo.html_url ?? ""
    }
}
