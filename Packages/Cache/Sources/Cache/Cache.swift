import Foundation
import UIKit
import Models

public final class Cache<Key: NSString, Value> {
    
    final class Entry {
        let value: Value
        
        init(value: Value) {
            self.value = value
        }
    }
    private let wrapped = NSCache<Key, Entry>()
    
    public func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        wrapped.setObject(entry, forKey: key)
    }
    
    public func value(forKey key: Key) -> Value? {
         let entry = wrapped.object(forKey: key)
         return entry?.value
     }
    
    public func removeValue(forKey key: Key) {
           wrapped.removeObject(forKey: key)
    }
}

public final class PromoCardsCache: NSObject, Sendable {
    nonisolated(unsafe) public static let shared = Cache<NSString, [PromoCardDecodable]>()
    private override init() {}
}

public final class ImageCache: NSObject, Sendable {
    nonisolated(unsafe) public static let shared = Cache<NSString, UIImage>()
    private override init() {}
}
