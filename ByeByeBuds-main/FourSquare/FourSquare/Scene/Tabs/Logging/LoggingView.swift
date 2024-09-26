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
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let timeArray = ["Morning", "Afternoon", "Evening", "Night"]
    
    @Binding var selectedTab: TabBarItem
    
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
                ScrollView {
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
                                Button(action: {
                                    //
                                }) {
                                    Text("Yes")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                }
                               
                                Spacer()
                                Button(action: {
                                    selectedTab = .home
                                }) {
                                    Text("Naa")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                }
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - 160)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 20 , height: 250)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "30444E"))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                            .cornerRadius(7)
                        VStack (alignment: .leading){
                            Text("At what time of the day you smoked?")
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.leading, 20)
                            
                            LazyVGrid(columns: rows, spacing: 10) {
                                // Create 4 pills with a white border
                                ForEach(0..<timeArray.count) { index in
                                    Text(timeArray[index])
                                        .font(.system(size: 12))
                                        .padding()
                                        .frame(width: 120)
                                        .background(Color(hex: "30444E"))
                                        .foregroundColor(.white)
                                        .clipShape(Capsule()) // Makes it pill-shaped
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.white, lineWidth: 2) // White border
                                        )
                                        .shadow(radius: 5) // Optional shadow
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: 90)
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "30444E"))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                            .cornerRadius(7)
                        VStack (alignment: .leading){
                            HStack {
                                Text("How Many you Somked today?")
                                    .foregroundStyle(.white)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: 90)
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "30444E"))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                            .cornerRadius(7)
                        VStack (alignment: .leading) {
                            HStack {
                                Text("Did you tried to avoid it?")
                                    .foregroundStyle(.white)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            
                            HStack {
                                // Create 4 pills with a white border
                                
                                Text("Yes")
                                    .font(.system(size: 12))
                                    .padding()
                                    .frame(width: 90)
                                    .background(Color(hex: "30444E"))
                                    .foregroundColor(.white)
                                    .clipShape(Capsule()) // Makes it pill-shaped
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.white, lineWidth: 2) // White border
                                    )
                                    .shadow(radius: 5) // Optional shadow
                                Spacer()
                                
                                Text("No")
                                    .font(.system(size: 12))
                                    .padding()
                                    .frame(width: 90)
                                    .background(Color(hex: "30444E"))
                                    .foregroundColor(.white)
                                    .clipShape(Capsule()) // Makes it pill-shaped
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.white, lineWidth: 2) // White border
                                    )
                                    .shadow(radius: 5) // Optional shadow
                                
                            }
                            .padding(.horizontal, 60)
                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: 90)
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                }
            }
        }
        .ignoresSafeArea()
        .padding(.top, 40)
        .padding(.bottom, 90)
    }
}

#Preview {
    LoggingView(selectedTab: .constant(.home))
}
