//
//  MusicHistoryTests.swift
//  MusicHistoryTests
//
//  Created by Vitaly Gromov on 8/27/22.
//

import XCTest
@testable import Music_History

class MusicHistoryTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SearchViewModel_searchResults_shouldBeEmpty() {
        // Given
        
        // When
        let vm = SearchViewModel()
        // Then
        XCTAssertEqual(vm.searchResults.count, 0)
        XCTAssertTrue(vm.searchResults.isEmpty)
    }
    
}
