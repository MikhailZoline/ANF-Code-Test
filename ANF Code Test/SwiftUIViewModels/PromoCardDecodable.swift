//
//  PromoCardDecodable.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/24/25.
//

import Foundation

public struct PromoCardDecodable: Decodable {
    
    public struct ShopActionDecodable: Decodable {
        public var target: URL
        public var title: String
    }
    
    var title: String
    var backgroundImage: String
    var content: [ShopActionDecodable]?
    var promoMessage: String?
    var topDescription: String?
    var bottomDescription: String?
    
    static var demoInstance: PromoCardDecodable {
        return (try? JSONDecoder().decode(PromoCardDecodable.self, from: JSONSerialization.data(withJSONObject: PromoCardDecodable.testJson)))!
    }
    
    static var testJson =
    [
      "title": "TOPS STARTING AT $12",
      "backgroundImage": "anf-20160527-app-m-shirts.jpg",
      "content": [
        [
          "target": "https://www.abercrombie.com/shop/us/mens-new-arrivals",
          "title": "Shop Men"
        ],
        [
          "target": "https://www.abercrombie.com/shop/us/womens-new-arrivals",
          "title": "Shop Women"
        ]
      ],
      "promoMessage": "USE CODE: 12345",
      "topDescription": "A&F ESSENTIALS",
      "bottomDescription": "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>"
    ] as [String : Any]
}

