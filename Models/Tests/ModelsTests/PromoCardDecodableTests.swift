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
    
    func test_PromoCardModelImage() throws {
        XCTAssertEqual(testInstance.backgroundImage, "anf-20160527-app-m-shirts.jpg")
    }

    func test_PromoCardModelShopActions() async throws {
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

}
