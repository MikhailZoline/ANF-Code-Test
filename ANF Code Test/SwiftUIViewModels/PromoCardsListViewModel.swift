//
//  ExplorePromoViewModel.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/28/25.
//

import SwiftUI
 
public func identity<T>(_ t: T) -> T { t }

@Observable class PromoCardsListViewModel {
    var promoCards: [PromoCardViewModel] = []
    init(promoCardsDecodable: [PromoCardDecodable]) {
        promoCards = promoCardsDecodable.map {
            return PromoCardViewModel(decodableData: $0)
        }
    }
    
    static var demoInstance: PromoCardsListViewModel {
        return .init(promoCardsDecodable: [.demoInstance, .demoInstance, .demoInstance])
    }
}
