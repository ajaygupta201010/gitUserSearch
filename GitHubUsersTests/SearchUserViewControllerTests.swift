//
//  SearchUserViewControllerTests.swift
//  GitHubUsersTests
//
//  Created by Ajay Gupta on 15/07/19.
//  Copyright © 2019 Ajay. All rights reserved.
//

import XCTest
@testable import GitHubUsers

class SearchUserViewControllerTests: XCTestCase {
    var searchVC: SearchUserViewController!
    var searchData: GitSearchUser?
    
    override func setUp() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        searchVC = storyboard.instantiateViewController(withIdentifier: "SearchUserViewController") as? SearchUserViewController
        UIApplication.shared.keyWindow?.rootViewController = searchVC
        
        if let filePath = Bundle.main.path(forResource: "SearchUserViewController", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
                let jsonDecoder = JSONDecoder()
                searchData = try jsonDecoder.decode(GitSearchUser.self, from: data)
                searchVC.searchResults = searchData?.users ?? []
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
        XCTAssertNotNil(searchVC.setup())
    }
    
    func testNumberOfRowsInSectionShouldReturnCorrectRows() {
        let expextedRows = 30
        let actualRows = searchVC.tableView(searchVC.usersList, numberOfRowsInSection: 0)
        XCTAssertTrue(expextedRows == actualRows)
    }
    
    func testCellForRowAtIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = searchVC.tableView(searchVC.usersList, cellForRowAt: indexPath) as? UserTableViewCell
        XCTAssertTrue(cell?.userNameLabel.text == "ajay")
        XCTAssertTrue(cell?.scoreLabel.text == "95.22149")
    }
    
    func testSearchBarOperations() {
    XCTAssertNotNil(searchVC.searchBarSearchButtonClicked(searchVC.searchVC.searchBar))
        
        searchVC.searchBarSearchButtonClicked(searchVC.searchVC.searchBar)
        XCTAssertTrue(searchVC.searchResults.isEmpty)
        
        let expectation = self.expectation(description: "searchResults_updated")
        searchVC.searchCall("ajay", page: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 11)
        XCTAssertTrue(searchVC.searchResults.count > 0, "Users Data fetched")
    }
}
