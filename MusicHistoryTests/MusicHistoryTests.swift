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
    
    func test_SearchViewModel_searchResults_NotEqualZero_WithIdFrom1To100_BadButWorks() {
        // Given
        let jsonModel = LocalJsonModel()
        let exp: XCTestExpectation = XCTestExpectation()
        let loopCoutFrom = 0
        let loopCountTo = 100
        var invalidArtistId = [Int]()
        var resultCount = 0
        
        // When
        for i in loopCoutFrom..<loopCountTo {
            let svm = SearchViewModel()
            svm.$searchResults
                .dropFirst()
                .debounce(for: 2, scheduler: RunLoop.main)
                .sink { results in
                    print("RESULTS GOT FOR --- id: \(jsonModel.allAtrists[i].id), \(jsonModel.allAtrists[i].artist) ---", svm.searchResults.count)
                    if results.count == 0 { invalidArtistId.append(jsonModel.allAtrists[i].id) }
                    resultCount += 1
                    if resultCount == (loopCountTo - loopCoutFrom) {
                        exp.fulfill() }
                }
                .store(in: &cancellables)
            
            svm.searchTermValue = jsonModel.allAtrists[i].artist + " " + jsonModel.allAtrists[i].album
        }
        
        // Then
        wait(for: [exp], timeout: 10)
        XCTAssertEqual(invalidArtistId, [])
        print("\n\n", invalidArtistId,"\n\n")
    }
    
    
}
