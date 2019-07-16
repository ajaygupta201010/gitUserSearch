//
//  UserDetailViewControllerTests.swift
//  GitHubUsersTests
//
//  Created by Ajay Gupta on 16/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import XCTest
@testable import GitHubUsers

class UserDetailViewControllerTests: XCTestCase {

    var detailVC: UserDetailViewController!
    var userDetail: GitUserProfile?
    
    override func setUp() {
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        detailVC = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController
        UIApplication.shared.keyWindow?.rootViewController = detailVC
        
        getUserDetailsData()
    }

    func getUserDetailsData() {
        if let filePath = Bundle.main.path(forResource: "UserDetailViewController", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
                let jsonDecoder = JSONDecoder()
                userDetail = try jsonDecoder.decode(GitUserProfile.self, from: data)
                detailVC.userProfileUrl = userDetail?.url ?? ""
                detailVC.userRepoUrl = userDetail?.repos_url ?? ""
                detailVC.setUserProfile(profile: userDetail)
                getRepoData()
            } catch {
                
            }
        }
    }
    
    func getRepoData() {
        if let filePath = Bundle.main.path(forResource: "UserRepoList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
                let jsonDecoder = JSONDecoder()
                let repoList = try jsonDecoder.decode(GitUserRepoList.self, from: data)
                if let repos = repoList.gitRepo, !repos.isEmpty {
                    detailVC.setRepoList(list: repos)
                }
            } catch {
                
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSetupVC() {
        XCTAssertNotNil(detailVC.setup())
    }

    func testUpdateUserDetails() {
        detailVC.updateUserDetails()
        XCTAssertNotNil(detailVC.updateUserDetails())
        XCTAssertEqual(detailVC.userFullName?.text, "Ajay Srivastava")
        XCTAssertEqual(detailVC.followers?.text, "14")
        XCTAssertEqual(detailVC.lastUpdateAtLabel?.text, "Jul 07, 2019")
    }
    
    func testNumberOfRowsInSectionShouldReturnCorrectRows() {
        let expextedRows = 21
        let actualRows = detailVC.tableView(detailVC.repositoriesTableView, numberOfRowsInSection: 0)
        XCTAssertTrue(expextedRows == actualRows)
    }
    
    func testCellForRowAtIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = detailVC.tableView(detailVC.repositoriesTableView, cellForRowAt: indexPath) as? RepoTableViewCell
        XCTAssertTrue(cell?.repoNameLabel.text == "ajay/ARGBot")
        XCTAssertTrue(cell?.repoDesriptionLabel.text == "Augmented Reality Game Bot (ARGBot)")
        XCTAssertTrue(cell?.forks.text == "2")
    }
    
}
