//
//  ExploreCardScrollView.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/28/25.
//

import SwiftUI

struct ExploreCardScrollView: View {
    var viewModel: PromoCardsListViewModel = .init()
    @State var promoCards: [PromoCardViewModel] = []
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    if !promoCards.isEmpty {
                        ForEach(promoCards.enumerated().map(identity), id: \.offset) {
                            PromoCardView(viewModel: $0.1)
                                .padding(.top)
                        }
                    } else {
                        ProgressView()
                            .padding(.all, 100)
                    }
                    
                }.navigationTitle(Text("Abercrombie&Fitch"))
            }
        }
        .task {
            await viewModel.getCardsAsync {
                switch $0 {
                case .success(let cards):
                    promoCards = cards
                case .failure(_): break
                }
            }
        }
    }
}

#Preview {
    ExploreCardScrollView()
}
