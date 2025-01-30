//
//  ExplorePromoViewModel.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/28/25.
//

import SwiftUI
import Models
import Combine
import Networking
 
public func identity<T>(_ t: T) -> T { t }

@MainActor @Observable class PromoCardsListViewModel {
    
    func getCardsAsync(completion: @escaping (Swift.Result<[PromoCardViewModel], NSError>) -> Void) async {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {// To simulate the asynchronisity of results
            Task.detached {
                await Networking.shared.getDecodableData(
                    ofType: [PromoCardDecodable].self,
                    inBundle: Bundle.main
                ) {
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
}
