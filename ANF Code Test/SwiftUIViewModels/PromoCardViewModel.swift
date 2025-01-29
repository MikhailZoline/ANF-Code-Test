//
//  PromoCardViewModel.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/24/25.
//

import Foundation

public struct ShopActionIdentifiable: Identifiable {
    public var id = UUID().uuidString
    public var decodable: PromoCardDecodable.ShopActionDecodable
}
    
@Observable class PromoCardViewModel {
    static var regex = try! NSRegularExpression(pattern: "(.*?)<a href=\"(.*?)\">(.*?)</a>")
    var decodable: PromoCardDecodable
    var title: String { return decodable.title }
    var bottomDescription: String?
    var bottomLink: URL?
    var topDescription: String { return decodable.topDescription != nil ? decodable.topDescription! : "" }
    var promoMessage: String { return decodable.promoMessage != nil ? decodable.promoMessage! : "" }
    var shopActions: Array<ShopActionIdentifiable> { return decodable.content != nil ?  decodable.content!.map {
        return ShopActionIdentifiable(decodable: $0)
    } : [] }
    
    init(decodableData: PromoCardDecodable) {
        self.decodable = decodableData
        if let html = decodableData.bottomDescription?.replacingOccurrences(of:"\\\"", with: "\"") {
            if let match = Self.regex.firstMatch(in: html, range: NSRange(html.startIndex..<html.endIndex, in: html)) {
                if let hRange = Range(match.range(at: 1), in: html) {
                    bottomDescription = String(html[hRange])
                }
                if let lRange = Range(match.range(at: 2), in: html) {
                    bottomLink = URL(string: String(html[lRange]))
                }
                if let fRange = Range(match.range(at: 3), in: html) {
                    bottomDescription?.append(String(html[fRange]))
                }
            }
        }
    }
}
