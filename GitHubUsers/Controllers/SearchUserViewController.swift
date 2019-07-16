//
//  SearchUserViewController.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 11/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {

    @IBOutlet weak var usersList: UITableView!
    var searchResults: [GitUser] = []
    
    var searchVC: UISearchController = {
        let vc = UISearchController(searchResultsController: nil)
        vc.searchBar.placeholder = "Please search users here..."
        vc.searchBar.tintColor = .white
        vc.searchBar.barStyle = .black
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: private and local methods
extension SearchUserViewController {
    func setup() {
        // navigation
        self.navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        // Removing unused cells
        self.usersList.tableFooterView = UIView()
    }
}

// MARK: event handlers
extension SearchUserViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UserDetailViewController {
            vc.userProfileUrl = (sender as? GitUser)?.url ?? ""
            vc.userRepoUrl = (sender as? GitUser)?.repos_url ?? ""
        }
    }
}


// MARK: UISearchBarDelegate
extension SearchUserViewController: UISearchBarDelegate {
    // when user press on 'search'
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchResults = []
        self.view.endEditing(true)
        self.searchCall(searchBar.text ?? "", page: 1)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}


// MARK: UITableViewDataSource
extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Search.resultCell, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let urlStr = self.searchResults[indexPath.row].avatar_url
        let name = self.searchResults[indexPath.row].login
        let score = self.searchResults[indexPath.row].score
        cell.configUI(avatarUrl: urlStr, name: name, score: score)
        return cell
    }
}

// MARK: UITableViewDelegate
extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueId = "segue_userDetails"
        performSegue(withIdentifier: segueId, sender: self.searchResults[indexPath.row])
    }
}

// MARK: server request
extension SearchUserViewController {
    func searchCall(_ searchText: String, page: Int) {
        guard !searchText.isEmpty else { return }
        ServiceManager.searchUsers(search: searchText, page: page, type: GitSearchUser.self, completion: { result in
            switch result {
            case .success(let object):
                self.searchResults = self.searchResults + (object.users ?? [])
                DispatchQueue.main.async { self.usersList.reloadData() }
            case .failure(_):
                break
            }
        })
    }
}
