//
//  PromoCardViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Mikhail Zoline on 1/27/25.
//

import XCTest
@testable import ANF_Code_Test

final class PromoCardViewModelTests: XCTestCase {
    
    var testInstance: PromoCardViewModel!

    override func setUp() async throws  {
        testInstance = .init(decodableData: .demoInstance)
        XCTAssertNotNil(testInstance)
    }

    override func tearDownWithError() throws {
        testInstance = nil
        XCTAssertNil(testInstance)
    }

    func test_PromoCardViewModelDecodableModel() async throws {
        XCTAssertNotNil(testInstance.decodable)
    }
    
    func test_PromoCardViewModelImage() async throws {
        XCTAssertEqual(testInstance.decodable.backgroundImage, "anf-20160527-app-m-shirts.jpg")
        XCTAssertNotNil(UIImage(named: testInstance.decodable.backgroundImage))
    }
    
    func test_PromoCardViewModelTitle() async throws {
        XCTAssertEqual(testInstance.title, "TOPS STARTING AT $12")
    }
    
    func test_PromoCardViewModelTopDescription() async throws {
        XCTAssertNotNil(testInstance.topDescription)
        XCTAssertEqual(testInstance.topDescription, "A&F ESSENTIALS")
    }
    
    func test_PromoCardViewModelPromoMessage() async throws {
        XCTAssertNotNil(testInstance.promoMessage)
        XCTAssertEqual(testInstance.promoMessage, "USE CODE: 12345")
    }
    
    func test_PromoCardViewModelShopActions() async throws {
        XCTAssertNotNil(testInstance.shopActions)
        XCTAssertEqual(testInstance.shopActions.count, 2)
        let firstAction = testInstance.shopActions.first
        XCTAssertNotNil(firstAction)
        XCTAssertNotNil(firstAction?.id)
        XCTAssertNotNil(firstAction?.decodable.target)
        let firstActionUrl = firstAction?.decodable.target
        XCTAssertNotNil(firstActionUrl)
        XCTAssertEqual(firstActionUrl?.absoluteString, "https://www.abercrombie.com/shop/us/mens-new-arrivals")
        XCTAssertEqual(firstAction?.decodable.title, "Shop Men")
    }
    
    func test_PromoCardViewModelBottomDescription() async throws {
        XCTAssertNotNil(testInstance.bottomDescription)
        XCTAssertEqual(testInstance.bottomDescription, "*In stores & online. Exclusions apply. See Details")
        XCTAssertEqual(testInstance.bottomLink?.absoluteString, "http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html")
    }
}
