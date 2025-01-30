import XCTest
import Models
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
        let url = await Networking.shared.url(for: Networking.RequestType.exploreData, inBundle: .module)
        XCTAssertNotNil(url)
        XCTAssertEqual(url.pathComponents.last, Networking.RequestType.exploreData.rawValue + ".json")
    }
    
    func test_NetworkingJsonData() async throws {
        let jsonData = await Networking.shared.jsonData(inBundle: .module)
        XCTAssertNotNil(jsonData)
    }
    
    func test_NetworkingParseDecodableData() async throws {
        if let localData = await Networking.shared.jsonData(inBundle: .module) {
            await Networking.shared.parse(ofType: [PromoCardDecodable].self, from: localData) { result in
                switch result {
                case.success( let decodables):
                    XCTAssertEqual(decodables.count, 10)
                case .failure(_):
                    XCTAssertEqual(true, false)
                }
            }
        }
    }
    
    func test_NetworkingParseDecodableModel() async throws {
        await Networking.shared.getDecodableData(
            ofType: [PromoCardDecodable].self,
            inBundle: .module
        ) {
            switch $0 {
            case .success(let decodables):
                XCTAssertEqual(decodables.count, 10)
            case .failure(_):
                XCTAssertEqual(true, false)
            }
        }
    }
}
