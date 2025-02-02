import SwiftUI
import Combine
import Models
import Cache

public final class Networking: NSObject, Sendable {
    
    @MainActor public static let shared = Networking()
    
    private override init() {}
    
    public enum RequestKeys: String, Sendable {
        case exploreLocalData = "exploreData"
        case exploreApiUrl = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.css"
        public var key: String { return self.rawValue }
    }
    
    public func url(for requestKey: RequestKeys, inBundle bundle: Bundle) -> URL {
        return bundle.url(forResource: requestKey.rawValue, withExtension: "json")!
    }
    
    @MainActor public func promoCardsData(forKey cacheKey: Networking.RequestKeys = .exploreLocalData) async -> [PromoCardDecodable]? {
        do {
            if let cacheData = PromoCardsCache.shared.value(forKey: cacheKey.key as NSString) {
                return cacheData
            } else if let cacheData = PromoCardsCache.shared.value(forKey: Networking.RequestKeys.exploreLocalData.key as NSString) {
                return cacheData
            }
        }
        return nil
    }

    @MainActor public func getCachedCards (
        forKey cacheKey: Networking.RequestKeys,
        completion: @escaping (Result<[PromoCardDecodable], NSError>) -> Void
    ) async {
        if let promoCards = await promoCardsData(forKey: cacheKey) {
            completion(Result.success(promoCards))
        }
    }
    
    @MainActor public func cacheModelsFromLocalJson() async {
        if let data =  try? Data(
            contentsOf: url(for: .exploreLocalData, inBundle: .module),
            options: .mappedIfSafe
        ),
           let promoCardsDecodable = try? JSONDecoder().decode([PromoCardDecodable].self, from: data) {
            PromoCardsCache.shared.insert(promoCardsDecodable, forKey: Networking.RequestKeys.exploreLocalData.key as NSString)
        }
    }
    
    public func fetchAsyncCardsAndPhotos() {
        Task {
            let asyncPhotos = AsyncCardsAndPhotos()
            do { for try await _ in asyncPhotos {} } catch {}
        }
    }
}

public struct AsyncCardsAndPhotos: AsyncSequence {
    
    public typealias Element = UIImage
    
    let request: URLRequest = URLRequest(url: .init(string: Networking.RequestKeys.exploreApiUrl.key)!)
    
    public init(){}
    
    public struct AsyncIterator: AsyncIteratorProtocol {
        let request: URLRequest
        var cardIterator: Array<PromoCardDecodable>.Iterator?
        
        mutating public func next() async throws -> UIImage? {
            if cardIterator == nil {
                let (data, response) = try await URLSession.shared.data(for: request)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let cards = try JSONDecoder().decode([PromoCardDecodable].self, from: data)
                PromoCardsCache.shared.insert(
                        cards,
                        forKey: Networking.RequestKeys.exploreApiUrl.key as NSString
                    )
                cardIterator = cards.makeIterator()
            }
            guard let card = cardIterator?.next() else {
                return nil
            }
            do {
                guard let imageURL = URL(string: card.backgroundImage) else {
                    throw URLError(.badURL)
                }
                let (imageData, imageResponse) = try await URLSession.shared.data(from: imageURL)
                guard (imageResponse as? HTTPURLResponse)?.statusCode == 200 else {
                    throw URLError(.fileDoesNotExist)
                }
                guard let image = UIImage(data: imageData) else {
                    throw URLError(.dataNotAllowed)
                }
                ImageCache.shared.insert(image, forKey: imageURL.absoluteString as NSString)
                return image
            } catch {
                print("Error Getting Image Data from API")
            }
            return nil
        }
    }
    
    public func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator(request: request)
    }
}
