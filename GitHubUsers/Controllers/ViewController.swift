//
//  ViewController.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    
    var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.barTintColor = .gray
        searchBar.placeholder = "Please enter user name here..."
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.dataSource = self
        self.navigationItem.titleView = searchBar
        self.navigationController?.setupNavigationBar()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userTableCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        cell.userImageView.image = UIImage(named: "userImage")
        cell.userNameLabel.text = "Ajay Gupta"
        cell.scoreLabel.text = "129"
        return cell
    }
}

extension UINavigationController {
    func setupNavigationBar() {
        self.navigationBar.barTintColor = .gray
    }
}

extension UIViewController {
    func addBackButton() {
        let backImage = UIImage(named: "back")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
