
//  ContentView.swift
//  FourSquare
//
//  Created by Abdul Khan on 24/09/24.


import SwiftUI

struct ContentView: View {
    @State var startButtonClicked: Bool = false
    let healthKitManager = HealthKitManager()
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Title for the main screen")
                            .foregroundColor(.black)
                            .font(.title)
                            .bold()
                            .padding(.bottom)
                        
                        Text("Description for the main screen Description for the main screen Description for the main screen Description for the main screen Description for the main screen Description for the main screen Description for the main screen Description for the main screen")
                            .foregroundColor(.black)
                            .font(.headline)
                        
                        Image("quitSmoking")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .cornerRadius(20)
                    }
                    .padding([.leading, .trailing], 16)
                    Spacer()
                    VStack(alignment: .center) {
                        
                        NavigationLink("", isActive: $startButtonClicked) {
                            // Questions View
                            SmokingSurveyView()
                        }
                        
                        Button(action: {
                            print("Button to start")
                            startButtonClicked = true
                        }, label: {
                            HStack {
                                Text("Start Assesement")
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .background(Color(hex: "#697cfb"))
                            .cornerRadius(24)
                        })
                    }
                }
                .padding(.bottom, 30)
                .navigationBarHidden(true)
            }
//            .background(Color(hex: ""))
            .frame(width: UIScreen.main.bounds.width)
            .onAppear {
                healthKitManager.requestAuthorization()
            }
        }
    }
}

#Preview {
    ContentView()
}

