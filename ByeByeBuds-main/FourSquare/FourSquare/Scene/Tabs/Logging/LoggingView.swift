//
//  LoggingView.swift
//  FourSquare
//
//  Created by Abdul Khan on 25/09/24.
//

import SwiftUI

struct LoggingView: View {
    @State var yesSelected: Bool = false
    @State var noSelected: Bool = false
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
            VStack( spacing: 20) {
                HStack {
                    Text("Logging")
                        .font(.title)
                        .foregroundStyle(Color.white)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top,40)
                ZStack {
                    Image("yellowCard")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 40 , height: 200)
                    VStack {
                        Text("Did you have a puff today?")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.bottom, 40)
                            .frame(alignment: .leading)
                            .padding(.horizontal, 20)
                        
                        HStack {
                            Text("Yes")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                            Text("Naa")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                        .frame(width: UIScreen.main.bounds.width - 160)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 20 , height: 250)
            }
        }
        .ignoresSafeArea()
        .padding(.top, 40)
    }
}

#Preview {
    LoggingView()
}
