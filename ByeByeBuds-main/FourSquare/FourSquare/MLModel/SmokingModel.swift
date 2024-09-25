//
//  SmokingPredictionModel.swift
//  demo
//
//  Created by Mindstix on 28/09/24.
//


import SwiftUI
import CoreML

struct SmokingModel: View {
    // Input parameters
    @State private var age: Double = 25
    @State private var smokingDuration: Double = 5
    @State private var timeOfDay: Double = 12
    @State private var cigarettesPerDay: Double = 10
    @State private var heartRate: Double = 80
    @State private var heartRateVariability: Double = 50
    
    // Output prediction
    @State private var isSmokingPrediction: String = "Unknown"
    @State var quoteArray: [String] = ["The journey of a thousand miles begins with a single step.", "It always seems impossible until it’s done.", "You didn’t come this far to only come this far.", "Your body will thank you for the rest of your life."]
    
    @State var index: Int = 0
    
    @State var timer = Timer.publish(every: TimeInterval(), on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                Image("redCard")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 40 , height: 200)
                VStack {
                    Text("No Cigarettes")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.bottom, 40)
                        .frame(alignment: .leading)
                        .padding(.trailing, 90)
                    
                    HStack {
                        
                        Spacer()
                        VStack {
                            Text("0")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.bottom, 5)
                            
                            Text("Streak")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 80)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 20 , height: 250)
            HStack {
                Text(quoteArray[index])
                    .font(.subheadline)
                    .italic()
                    .fontWeight(.medium)
                    .frame(alignment: .center)
            }
            .frame(height: 70)
            .padding(.horizontal, 120)
            HStack {
                ZStack {
                    Rectangle()
                        .fill(Color(hex: "#3ED598"))
                        .frame(width: (UIScreen.main.bounds.width / 2) - 20, height: 150)
                        .cornerRadius(8)
                    VStack (alignment: .leading){
                        Text("Life Regained")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.bottom, 5)
                        Text("--/-- Hours")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.bottom, 5)
                    }
                    .frame(width: (UIScreen.main.bounds.width / 2) - 40)
                }
                ZStack {
                    Rectangle()
                        .fill(Color(hex: "#FFC542"))
                        .frame(width: (UIScreen.main.bounds.width / 2) - 20, height: 150)
                        .cornerRadius(8)
                    VStack (alignment: .leading){
                        Text("Money Saved")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.bottom, 5)
                        Text("0.1 Rs")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.bottom, 5)
                    }
                    .frame(width: (UIScreen.main.bounds.width / 2) - 40)
                }
            }
            .padding(.horizontal, 40)
            .onReceive(timer) { _ in
                timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
                withAnimation {
                    // Increment the selected tab in a cyclic manner
                    withAnimation(.easeInOut) {
                        if index < quoteArray.count - 1 {
                            index = (index + 1)
                        } else {
                            index = 0
                        }
                        
                    }
                }
            }
            VStack(spacing: 5) {
                ZStack {
                    Rectangle()
                        .fill(Color(hex: "#623A42"))
                        .frame(width: UIScreen.main.bounds.width - 30, height: 80)
                        .cornerRadius(8)
                    HStack(spacing: 3){
                        ZStack {
                            Circle()
                                .frame(width:38, height: 38)
                                .foregroundStyle(Color(hex: "#FF565E"))
                                .padding(.trailing, 7)
                            LottieView(lottieFile: "heartLottie")
                                .frame(width:38, height: 38)
                        }
                        Text("Heart Rate")
                        Spacer()
                        Text("86 BPM")
                    }
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#FF565E"))
                    .frame(width: UIScreen.main.bounds.width - 60)
                }
                ZStack {
                    Rectangle()
                        .fill(Color(hex: "#286053"))
                        .frame(width: UIScreen.main.bounds.width - 30, height: 80)
                        .cornerRadius(8)
                    HStack(spacing: 3){
                        ZStack {
                            Circle()
                                .frame(width:38, height: 38)
                                .foregroundStyle(Color(hex: "#3DD598"))
                                .padding(.trailing, 7)
                            LottieView(lottieFile: "lotusLottie")
                                .frame(width:35, height: 35)
                        }
                        Text("Stress")
                        Spacer()
                        Text("Low")
                    }
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#3DD598"))
                    .frame(width: UIScreen.main.bounds.width - 60)
                }
                ZStack {
                    Rectangle()
                        .fill(Color(hex: "#625B39"))
                        .frame(width: UIScreen.main.bounds.width - 30, height: 80)
                        .cornerRadius(8)
                    HStack(spacing: 3){
                        ZStack {
                            Circle()
                                .frame(width:38, height: 38)
                                .foregroundStyle(Color(hex: "#FFC542"))
                                .padding(.trailing, 7)
                            LottieView(lottieFile: "shoesLottie")
                                .frame(width:34, height: 34)
                        }
                        Text("Steps")
                        Spacer()
                        Text("543")
                    }
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#FFC542"))
                    .frame(width: UIScreen.main.bounds.width - 60)
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 100)
        }
    }
    func predictSmokingStatus() {
        // Load the model
        
        guard let model = try? smokingPredictionModel(configuration: .init()) else {
            isSmokingPrediction = "Model loading failed"
            return
        }
        
        do {
            // Create input based on model features
            let input = smokingPredictionModelInput(age: Int64(age),
                                                    smoking_duration: Int64(smokingDuration),
                                                    time_of_day: Int64(timeOfDay),
                                                    cigarettes_per_day: Int64(cigarettesPerDay),
                                                    heart_rate: Int64(heartRate),
                                                    hr_variability: Int64(heartRateVariability))
            
            // Get prediction
            let prediction = try model.prediction(input: input)
            
            // Update the UI
            isSmokingPrediction = prediction.is_smoking > 0.3 ? "Smoking" : "Not Smoking"
        } catch {
            isSmokingPrediction = "Prediction failed"
        }
    }
}

struct SmokingPredictionModel_Previews: PreviewProvider {
    static var previews: some View {
        SmokingModel()
    }
}
