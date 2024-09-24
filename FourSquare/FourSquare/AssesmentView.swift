//
//  AssesmentView.swift
//  FourSquare
//
//  Created by Abdul Khan on 24/09/24.
//

import SwiftUI

struct SmokingSurveyView: View {
    @State private var name: String = ""
    @State private var doYouSmoke: Bool = false
    @State private var smokingDays: String = ""
    @State private var dailyUrge: String = ""
    @State private var quitAttempts: String = ""
    @State private var reasonsToQuit: String = ""
    @State private var goTOCustomTabBar: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationLink("", isActive: $goTOCustomTabBar) {
                // Questions View
                CustomTabBarView()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Color.clear
                    Text("What is your name?")
                        .font(.headline)
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Do you smoke?")
                        .font(.headline)
                    Toggle(isOn: $doYouSmoke) {
                        Text(doYouSmoke ? "Yes" : "No")
                    }
                    
                    if doYouSmoke {
                        Text("How many days have you been smoking?")
                            .font(.headline)
                        TextField("Enter number of days", text: $smokingDays)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        
                        Text("How strong is your daily urge to smoke (1-10)?")
                            .font(.headline)
                        TextField("Enter urge level", text: $dailyUrge)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        
                        Text("How many times have you attempted to quit?")
                            .font(.headline)
                        TextField("Enter number of attempts", text: $quitAttempts)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        
                        Text("What are your reasons for wanting to quit?")
                            .font(.headline)
                        TextField("Enter your reasons", text: $reasonsToQuit)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width - 40)
            }
            .padding(.vertical, 80)
            .padding(.bottom, 30)
            VStack {
                Button(action: {
                    goTOCustomTabBar = true
                }, label: {
                    HStack {
                        Text("Complete Assesement")
                            .foregroundStyle(.white)
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                    .background(.black)
                    .cornerRadius(24)
                })
            }
            .padding(.bottom, 40)
        }
        .ignoresSafeArea()
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct SmokingSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SmokingSurveyView()
    }
}

