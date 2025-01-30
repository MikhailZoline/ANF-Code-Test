//
//  PromoCardsListViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Mikhail Zoline on 1/29/25.
//

import XCTest

final class PromoCardsListViewModelTests: XCTestCase {

    func test_PromoCardsListViewModel() async throws {
        let testInstance: PromoCardsListViewModel = await .init()
        XCTAssertNotNil(testInstance)
        await testInstance.getCardsAsync {
            switch $0 {
            case .success(let cards):
                XCTAssertNotNil(cards)
                XCTAssertEqual(cards.count, 10)
            case .failure(_):
                XCTAssertEqual(true, false)
            }
        }
    }
}
