import XCTest
@testable import Models

final class PromoCardDecodableTests: XCTestCase {

    var testInstance: PromoCardDecodable!
    override func setUpWithError() throws {
        testInstance = try? JSONDecoder().decode(PromoCardDecodable.self, from: JSONSerialization.data(withJSONObject: PromoCardDecodable.testJson))
        XCTAssertNotNil(testInstance)
    }

    override func tearDownWithError() throws {
        testInstance = nil
        XCTAssertNil(testInstance)
    }

    func test_PromoCardModelTitle() throws {
        XCTAssertEqual(testInstance.title, "TOPS STARTING AT $12")
    }
    
    func test_PromoCardModelBackgroundImage() throws {
        XCTAssertEqual(testInstance.backgroundImage, "anf-20160527-app-m-shirts.jpg")
    }

    func test_PromoCardModelContent() async throws {
        XCTAssertNotNil(testInstance.content)
        let shopActions = testInstance.content
        XCTAssertNotNil(shopActions)
        XCTAssertEqual(shopActions?.count, 2)
        let firstAction = shopActions?.first
        XCTAssertNotNil(firstAction)
        let firstActionUrl = firstAction?.target
        XCTAssertNotNil(firstActionUrl)
        let contents = try String(contentsOf: firstActionUrl!)
        XCTAssertNotNil(contents)
        XCTAssertEqual(firstActionUrl?.absoluteString, "https://www.abercrombie.com/shop/us/mens-new-arrivals")
        XCTAssertEqual(firstAction?.title, "Shop Men")
    }

    func test_PromoCardPromoMessage() async throws {
        XCTAssertNotNil(testInstance.promoMessage)
        XCTAssertEqual(testInstance.promoMessage, "USE CODE: 12345")
    }
    
    func test_PromoCardTopDescription() async throws {
        XCTAssertNotNil(testInstance.topDescription)
        XCTAssertEqual(testInstance.topDescription, "A&F ESSENTIALS")
    }
    
    func test_PromoCardBottomDescription() async throws {
        XCTAssertNotNil(testInstance.bottomDescription)
        XCTAssertEqual(
            testInstance.bottomDescription,
            "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>"
        )
    }
}
