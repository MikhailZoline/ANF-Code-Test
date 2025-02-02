import XCTest
import Models
import Cache

@testable import Networking

final class NetworkingTests: XCTestCase {
    var testInstance: Networking!
    func setUpWithError() async throws {
        testInstance = await Networking.shared
        XCTAssertNotNil(testInstance)
    }
    
    override func tearDownWithError() throws {
        testInstance = nil
        XCTAssertNil(testInstance)
    }
    
    func test_NetworkingSharedInstance() async throws {
        let shared = await Networking.shared
        XCTAssertNotNil(shared)
    }
    
    func test_NetworkingUrl() async throws {
        let url = await Networking.shared.url(for: Networking.RequestKeys.exploreLocalData, inBundle: .module)
        XCTAssertNotNil(url)
        XCTAssertEqual(url.pathComponents.last, Networking.RequestKeys.exploreLocalData.key + ".json")
    }
    
    func test_NetworkingGetCachedCards() async throws {
        await Networking.shared.getCachedCards(forKey: .exploreLocalData) {
            switch $0 {
            case .success(let decodables):
                XCTAssertNotNil(decodables)
                XCTAssertEqual(decodables.count, 10)
            case .failure(_):
                XCTAssertEqual(true, false)
                break
            }
        }
    }
    
    func test_NetworkingCacheModelsFromLocalJson() async throws {
        await Networking.shared.cacheModelsFromLocalJson()
        XCTAssertNotNil(
            PromoCardsCache.shared.value(forKey: Networking.RequestKeys.exploreLocalData.key as NSString)
        )
        let decodedCards: [PromoCardDecodable] = PromoCardsCache.shared.value(
            forKey: Networking.RequestKeys.exploreLocalData.key as NSString
        )!
        XCTAssertNotNil(decodedCards)
        XCTAssertEqual(decodedCards.count, 10)
    }
    
    @MainActor func test_NetworkingFetchAsyncCardsAndPhotos() async throws {
        Networking.shared.fetchAsyncCardsAndPhotos()
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 11 )
        XCTAssertNotNil(PromoCardsCache.shared.value(forKey: Networking.RequestKeys.exploreApiUrl.key as NSString))
        let decodedCards: [PromoCardDecodable] = PromoCardsCache.shared.value(
            forKey: Networking.RequestKeys.exploreApiUrl.key as NSString
        )!
        let firstImageKey = decodedCards.first?.backgroundImage
        XCTAssertNotNil(firstImageKey)
        XCTAssertNotNil(ImageCache.shared.value(forKey: firstImageKey! as NSString))
        
    }

}
