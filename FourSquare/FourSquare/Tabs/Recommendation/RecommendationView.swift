//
//  RecommendationView.swift
//  FourSquare
//
//  Created by Abdul Khan on 25/09/24.
//

import SwiftUI

struct RecommendationView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Recommendations")
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .bold()
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    .padding(.top,25)
                }
        }
        .padding(.top, 40)
    }
}

#Preview {
    RecommendationView()
}
