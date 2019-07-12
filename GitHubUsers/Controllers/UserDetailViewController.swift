//
//  UserDetailViewController.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 12/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var lastUpdateAtLabel: UILabel!
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackButton()
        repositoriesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repoTableCell", for: indexPath) as? RepoTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

