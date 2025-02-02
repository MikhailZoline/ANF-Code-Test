//
//  FontSelectionView.swift
//  ANF Code Test
//
//  Created by Mikhail Zoline on 1/28/25.
//

import SwiftUI

struct FontView: View {
    var body: some View {
        VStack (spacing: 12){
            VStack(spacing: 2) {
                Text("A&F ESSENTIALS")
                    .font(.system(size: 22, weight: .regular, design: .serif))
                Text("TOPS STARTING AT $12")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.semibold)
                Text("USE CODE: 12345")
                    .font(.system(size: 18, weight: .regular, design: .monospaced))
            }
            Text("*In stores & online. Exclusions apply. See Details")
                .font(.callout)
                .fontWeight(.medium)
                .fontDesign(.rounded)
            Text("Shop Men")
                .font(.title)
                .fontWeight(.regular)
                .fontDesign(.serif)
            Text("Shop Women")
                .font(.title)
                .fontWeight(.regular)
                .fontDesign(.serif)
        }
    }
}

#Preview {
    FontView()
}
