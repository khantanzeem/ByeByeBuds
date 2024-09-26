//
//  HomeScreenView.swift
//  FourSquare
//
//  Created by Abdul Khan on 25/09/24.
//

import SwiftUI

struct HomeScreenView: View {
    @State var smoking: Bool = false
    @Binding var selectedTab: TabBarItem
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Home")
                        .font(.title)
                        .foregroundStyle(Color.white)
                        .bold()
                        .padding(.leading, 30)
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top,25)
                ScrollView(showsIndicators: false){
                    SmokingModel(somking: $smoking)
                }
            }
            if smoking {
                ZStack {
                    Color.black.opacity(0.9)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    ZStack {
                        Image("redCard")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 40 , height: 200)
                        VStack {
                            Text("Feeling the urge to smoke?")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.bottom, 40)
                                .frame(alignment: .leading)
                                .padding(.horizontal, 20)
                            
                            HStack {
                                Button(action: {
                                    selectedTab = .recommendedSection
                                    smoking = false
                                }, label: {
                                    Text("Yes")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)})
                                Spacer()
                                Button(action: {
                                    smoking = false
                                }, label: {
                                    Text("Naa")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)})
                               
                            }
                            .frame(width: UIScreen.main.bounds.width - 160)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 20 , height: 250)
                }
            }
        }
        .padding(.top, 40)
    }
}

#Preview {
    HomeScreenView(selectedTab: .constant(.home))
}
