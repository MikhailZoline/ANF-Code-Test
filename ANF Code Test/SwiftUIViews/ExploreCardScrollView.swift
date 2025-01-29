//
//  ExploreCardScrollView.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/28/25.
//

import SwiftUI

struct ExploreCardScrollView: View {
    var viewModel: PromoCardsListViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.promoCards.enumerated().map(identity), id: \.offset) {
                        PromoCardView(viewModel: $0.1)
                        .padding(.top)
                    }
                    
                }.navigationTitle(Text("Abercrombie&Fitch"))
            }
        }
    }
}

#Preview {
    ExploreCardScrollView(viewModel: .init(promoCardsDecodable: UIViewController.exploreData ?? []))
}
