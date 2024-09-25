//
//  HomeScreenView.swift
//  FourSquare
//
//  Created by Abdul Khan on 25/09/24.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Home")
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
    HomeScreenView()
}
