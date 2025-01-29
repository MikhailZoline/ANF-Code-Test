//
//  ANFExploreCardHostingController_.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/29/25.
//

import UIKit
import SwiftUI


class ANFExploreCardScrollController : UIHostingController<ExploreCardScrollView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: .init(viewModel: .init(promoCardsDecodable: Self.exploreData ?? [])))
    }
}
