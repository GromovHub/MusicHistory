//
//  MusicHistoryTests.swift
//  MusicHistoryTests
//
//  Created by Vitaly Gromov on 8/27/22.
//

import XCTest
import Combine
@testable import Music_History

class MusicHistoryTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("hello")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("bye")
    }

    func test_SearchViewModel_searchResults_shouldBeEmpty() {
        // Given
        
        // When
        let vm = SearchViewModel()
        // Then
        XCTAssertEqual(vm.searchResults.count, 0)
        XCTAssertTrue(vm.searchResults.isEmpty)
    }
    
    
    func test_SearchViewModel_searchResults_shouldBeGreaterThan0_Combine() {
        // Given
        let vm = SearchViewModel()
        let exp = XCTestExpectation()
        vm.$searchResults
            .dropFirst()
            .sink { val in
                exp.fulfill()
            }
            .store(in: &cancellables)
        // When
        vm.searchTermValue = "Mike"
        
        // Then
        wait(for: [exp], timeout: 10)
        XCTAssertGreaterThan(vm.searchResults.count, 0)
    }
    
    
    
}
