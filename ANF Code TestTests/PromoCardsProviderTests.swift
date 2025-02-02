//
//  PromoCardsProviderTests.swift
//  ANF Code TestTests
//
//  Created by Mikhail Zoline on 1/29/25.
//

import XCTest

final class PromoCardsProviderTests: XCTestCase {

    func test_PromoCardsProvider() async throws {
        let testInstance: PromoCardsProvider = await .init(cacheSource: .locally)
        XCTAssertNotNil(testInstance)
        await testInstance.getCachedCards {
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
