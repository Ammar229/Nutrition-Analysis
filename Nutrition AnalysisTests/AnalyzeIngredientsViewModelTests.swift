//
//  AnalyzeIngredientsViewModelTests.swift
//  Nutrition AnalysisTests
//
//  Created by Ammar on 07/08/2021.
//

import XCTest
@testable import Nutrition_Analysis

class AnalyzeIngredientsViewModelTests: XCTestCase {
    
    var sut: AnalyzeIngredientsViewModel!
    var mockedNetwork: MockedIngredientsManager!

    override func setUpWithError() throws {
        mockedNetwork = .init()
        sut = AnalyzeIngredientsViewModel(ingredientsManager: mockedNetwork)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockedNetwork = nil
        sut = nil
        
    }

    func testAnalyeTextTakesStringThenSetsResult() throws {
        // Given
        sut.text.accept("120 g egg\n100 g chicken")
        
        // When
        sut.analyeText()
        
        // Then
        XCTAssertEqual(sut.resultText?.count, 2)
        XCTAssertTrue(sut.text.value.isEmpty)
    }

    func testGetIngredientsDetialsWhenSuccess() {
        // Given
        mockedNetwork.success = true
        
        // When
        sut.getIngredientsDetials(for: ["123", "12345","1"])
        
        // Then
        wait(for: 1) // until DispatchGroup notify
        XCTAssertEqual(self.sut.ingredientsDetails.value.count, 3)
        XCTAssertEqual(self.sut.loadingStatus.value, .populated)
    }
    
    func testGetIngredientsDetialsWhenFail() {
        // Given
        mockedNetwork.success = false
        
        // When
        sut.getIngredientsDetials(for: ["123", "12345","1"])
        
        // Then
        wait(for: 1) // until DispatchGroup notify
        XCTAssertEqual(self.sut.ingredientsDetails.value.count, 0)
        XCTAssertEqual(self.sut.loadingStatus.value, .error("Faild Test"))
    }
    

}


// make xctest wait seconds
extension XCTestCase {

  func wait(for duration: TimeInterval) {
    let waitExpectation = expectation(description: "Waiting")

    let when = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: when) {
      waitExpectation.fulfill()
    }

    // We use a buffer here to avoid flakiness with Timer on CI
    waitForExpectations(timeout: duration + 0.5)
  }
}

// Make datastage check equality
extension DataState: Equatable {
    public static func == (lhs: DataState, rhs: DataState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.populated, .populated):
            return true
        case (.empty, .empty):
            return true
        case (let .error(lmsg), let .error(rmsg)):
            return lmsg == rmsg
        default:
            return false
        }
    }
}


