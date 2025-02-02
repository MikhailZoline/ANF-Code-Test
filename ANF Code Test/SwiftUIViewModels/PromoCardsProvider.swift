//
//  PromoCardsProviderService.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/28/25.
//

import SwiftUI
import Models
import Combine
import Networking

@MainActor @Observable class PromoCardsProvider {
    enum CacheSource {
        case locally
        case fromApi
    }
    var cacheSource: CacheSource
    
    init(cacheSource: CacheSource) {
        self.cacheSource = cacheSource
    }
    
    func getCachedCards(completion: @escaping (Swift.Result<[PromoCardViewModel], NSError>) -> Void) async {
        Task.detached {
            await Networking.shared.getCachedCards(forKey: self.cacheSource == .locally ? .exploreLocalData : .exploreApiUrl) {
                switch $0 {
                case .success(let decodables):
                    let cardViewModels = decodables.map {
                        return PromoCardViewModel(decodableData: $0)
                    }
                    completion(.success(cardViewModels))
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
}
