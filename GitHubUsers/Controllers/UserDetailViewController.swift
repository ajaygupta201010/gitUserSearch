//
//  UserDetailViewController.swift
//  GitHubUsers
//
//  Created by Ajay Gupta on 12/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    // pass data from previous viewController
    var userProfileUrl: String = ""
    var userRepoUrl: String = ""
    
    private var userProfile: GitUserProfile?
    private var repoList: [GitUserRepo] = []
    
    @IBOutlet weak var userDetailView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var companyOrLocationName: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var lastUpdateAtLabel: UILabel!
    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var companyOrLocationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func shareButtonClicked(_ sender: Any) {
        shareUserDetails()
    }
    
    func setUserProfile(profile: GitUserProfile?) {
        userProfile = profile
    }
    
    func setRepoList(list: [GitUserRepo]) {
        repoList = list
    }
}

// MARK: private and local methods
extension UserDetailViewController {
    func setup() {
        repositoriesTableView.dataSource = self
        repositoriesTableView.tableFooterView = UIView()
        self.fetchUserProfileDetails(url: userProfileUrl)
    }
    
    func updateUserDetails() {
        guard let usrProfile = userProfile else { return }
        fetchAvatar(urlStr: userProfile?.avatar_url ?? "")
        userFullName.text = usrProfile.name
        followers.text = String(describing: usrProfile.followers ?? 0)
        lastUpdateAtLabel.text = Utility.convertDate(usrProfile.updated_at ?? "")
        
        let isCompanyNameEmpty = (userProfile?.company?.isEmpty ?? false)
        
        companyOrLocationLabel.text = isCompanyNameEmpty ? Constants.GitProfile.userLocationLabel : Constants.GitProfile.companyNameLabel
        companyOrLocationName.text = usrProfile.company ?? userProfile?.location
        
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

// MARK: UITableViewDataSource
extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = Constants.GitProfile.repoCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RepoTableViewCell else {
            return UITableViewCell()
        }
        cell.configUI(repo: repoList[indexPath.row])
        return cell
    }
}

// MARK: service calls
extension UserDetailViewController {
    func fetchUserProfileDetails(url: String) {
        ServiceManager.fetchUserProfile(url: url, type: GitUserProfile.self) { (usrProfile) in
            self.setUserProfile(profile: usrProfile)
            DispatchQueue.main.async {
                self.updateUserDetails()
            }
            
            if let repos = usrProfile?.repo, !repos.isEmpty {
                self.setRepoList(list: repos)
                //self.repoList = repos
                DispatchQueue.main.async {
                    self.repositoriesTableView.reloadData()
                }
            }
        }
    }
}

// MARK: Share user info with other Apps
extension UserDetailViewController {
    
    func shareUserDetails() {
   /// uncomment below code if need user profile as image
        
 /*       var screenShotImage: UIImage?
        let scale = UIScreen.main.scale
        let size = CGSize(width: userDetailView.frame.size.width, height: (userDetailView.frame.size.height - 50))

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        userDetailView.layer.render(in: context)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
 */
        let url = URL(string: userProfile?.html_url ?? "www.github.com")
        let shareText =  "\n \(userProfile?.name ?? "")"
        
        Utility.shareDetailsWithOtherApps(viewController: self, url: url,
                                          text: shareText)
    }
}
