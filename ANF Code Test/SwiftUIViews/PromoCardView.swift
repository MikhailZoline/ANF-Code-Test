//
//  PromoCardView.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/24/25.
//

import SwiftUI
import Cache

struct PromoCardView: View {
    var viewModel: PromoCardViewModel
    @State private var img: UIImage?

    var body: some View {
        LazyVStack {
            if img != nil {
                Image(uiImage: img!)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 90)
                    .padding(.vertical,40)
            }
            VStack(spacing: 2) {
                Text(verbatim: viewModel.topDescription)
                    .font(.system(size: 22, weight: .regular, design: .serif))
                Text(verbatim: viewModel.decodable.title)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.semibold)
                Text(verbatim: viewModel.promoMessage)
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
            }
            .padding()
            Spacer()
            if viewModel.bottomLink != nil &&
                viewModel.bottomDescription != nil {
                Link(viewModel.bottomDescription!, destination: viewModel.bottomLink!)
                    .font(.callout)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
            }
            VStack {
                ForEach(viewModel.shopActions) { action in
                    Link(destination: action.decodable.target) {
                        Text(verbatim:  action.decodable.title)
                            .foregroundStyle(.black)
                            .font(.title2)
                            .fontWeight(.medium)
                            .fontDesign(.serif)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                    }
                    .border(.black, width: 1.8)
                    .padding(.horizontal)
                }
            }
        }
        .task {
            if let cachedImage = ImageCache.shared.value(forKey: viewModel.decodable.backgroundImage as NSString) {
                img = cachedImage
            } else if let localImage = UIImage(named: viewModel.decodable.backgroundImage) {
                img = localImage
            }
        }
    }
}

#Preview {
    PromoCardView(viewModel: .init(decodableData: .demoInstance))
}
