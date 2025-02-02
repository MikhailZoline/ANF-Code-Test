import XCTest
import Models

@testable import Cache

final class CacheTests: XCTestCase {
    
    func test_PromoCardsCacheInstance() async throws {
        XCTAssertNotNil(PromoCardsCache.shared)
    }
    
    func test_PromoCardsCacheInsertRetrieve() async throws {
        let cardDecodable: PromoCardDecodable = PromoCardDecodable.demoInstance
        PromoCardsCache.shared.insert(
            [cardDecodable],
            forKey: cardDecodable.backgroundImage as NSString
        )
        XCTAssertNotNil(
            PromoCardsCache.shared.value(forKey: cardDecodable.backgroundImage as NSString))
        XCTAssertEqual(
            PromoCardsCache.shared.value(forKey: cardDecodable.backgroundImage as NSString)?.count, 1
        )
    }
    
    func test_ImageCacheInstance() async throws {
        XCTAssertNotNil(ImageCache.shared)
    }
    
    func test_ImageCacheInsertRetrieve() async throws {
        XCTAssertNotNil(ImageCache.shared)
        ImageCache.shared.insert(UIImage(systemName: "photo")!, forKey: "photo")
        XCTAssertNotNil(ImageCache.shared.value(forKey: "photo"))
    }
}

