//
//  PromoCardsListViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Mikhail Zoline on 1/29/25.
//

import XCTest

final class PromoCardsListViewModelTests: XCTestCase {
    
    var testInstance: PromoCardsListViewModel!
    
    override func setUpWithError() throws {
        testInstance = .demoInstance
        XCTAssertNotNil(testInstance)
    }

    override func tearDownWithError() throws {
        testInstance = nil
        XCTAssertNil(testInstance)
    }

    func test_PromoCardsListViewModel() throws {
        XCTAssertNotNil(testInstance)
        XCTAssertNotNil(testInstance.promoCards)
        XCTAssertEqual(testInstance.promoCards.count, 3)
    }

}
