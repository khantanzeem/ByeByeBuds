//
//  AssessmentLandingView.swift
//  FourSquare
//
//  Created by Mindstix on 25/09/24.
//

import SwiftUI

struct AssessmentLandingView: View {
    @State var startButtonClicked: Bool = false
    let healthKitManager = HealthKitManager()
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Hi, User!")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("Let't get started with the assessment")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("The assessment will take around 10 minutes. And helps our AL to understand your health better. It modifies itself based on your answers.")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    NavigationLink("", isActive: $startButtonClicked) {
                        // Questions View
                        SmokingSurveyViewV2()
                    }
                    
                    Button(action: {
                        print("Button to start")
                        startButtonClicked = true
                    }, label: {
                        HStack {
                            Text("Start!")
                                .bold()
                                .foregroundStyle(.white)
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 30, height: 24)
                                .foregroundStyle(.white)
                        }
                        .frame(width: 120, height: 60)
                        .background(Color(hex: "#3ED598"))
                        .cornerRadius(24)
                    })
                }
                .frame(width: UIScreen.main.bounds.width - 150)
            }
            .frame(width: UIScreen.main.bounds.width - 20)
            .padding(.bottom, 30)
            .navigationBarHidden(true)
        }
        .frame(width: UIScreen.main.bounds.width)
        .onAppear {
            healthKitManager.requestAuthorization()
        }
    }
}

#Preview {
    AssessmentLandingView()
}

