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
        
        if let filePath = Bundle.main.path(forResource: "UserDetailViewController", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
                let jsonDecoder = JSONDecoder()
                userDetail = try jsonDecoder.decode(GitUserProfile.self, from: data)
                detailVC.userProfileUrl = userDetail?.url ?? ""
                detailVC.userRepoUrl = userDetail?.repos_url ?? ""
                //searchVC.searchResults = searchData?.users ?? []
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

}
