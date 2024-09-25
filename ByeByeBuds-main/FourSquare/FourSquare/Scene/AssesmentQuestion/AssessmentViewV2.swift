//
//  AssessmentViewV2.swift
//  FourSquare
//
//  Created by Mindstix on 26/09/24.
//

//
//  AssesmentView.swift
//  FourSquare
//
//  Created by Abdul Khan on 24/09/24.
//

import SwiftUI
import HealthKit

struct SmokingSurveyViewV2: View {
    @State private var goToCustomTabBar: Bool = false
    @State private var currentQuestionIndex: Int = 0
    @State var questionDictionary: [String : String] = [
        "question1" : "What is your age?",
        "question2" : "When did you quit smoking?",
        "question3" : "How many cigarettes do you smoke per day?",
        "question4" : "What is the price of a cigarette?"
    ]
    
    let orderedQuestions: [String] = ["question1", "question2", "question3", "question4"]

    
    var body: some View {
        ZStack(alignment: .top) {
            Color(hex: "#22333b")
            NavigationLink("", isActive: $goToCustomTabBar) {
                            // Questions View
                            CustomTabBarView()
                        }
            if currentQuestionIndex != 0 {
                HStack {
                    Button {
                        print("Back Button")
                        currentQuestionIndex = currentQuestionIndex - 1
                    } label: {
                        Image(systemName: "arrowshape.left.fill")
                            .foregroundColor(Color(hex: "#ff575e"))
                    }
                    
                    Spacer()
                }
                .padding()
                .padding(.top,40)
            }

            VStack {
                // Display the current question view based on the index
                if currentQuestionIndex < questionDictionary.count {
                    let questionKey = orderedQuestions[currentQuestionIndex]
                    if questionKey == "question1" {
                        CigaretteCountView(question: questionDictionary[questionKey] ?? "", questionID: questionKey, nextAction: goToNextQuestion)
                    } else if questionKey == "question2"  {
                        QuitSmokingQuestionView(nextAction: goToNextQuestion, questionID: questionKey)
                    } else if questionKey == "question3"  {
                        CigaretteCountView(question: questionDictionary[questionKey] ?? "", questionID: questionKey,nextAction: goToNextQuestion)
                    } else if questionKey == "question4"  {
                        CigaretteCountView(question: questionDictionary[questionKey] ?? "", questionID: questionKey,nextAction: goToNextQuestion)
                    }
                } else {
                    // Show completion or move to another view when done with questions
                    SmokeFreeView(goToCustomTabBar: $goToCustomTabBar)
                }
            }
        }
        .onAppear {
            // Add any initial setup if needed
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .frame(width: UIScreen.main.bounds.width)
    }
    
    // Function to go to the next question
    private func goToNextQuestion() {
        if currentQuestionIndex < questionDictionary.count - 1 {
            currentQuestionIndex += 1
        } else {
            // End of survey or move to the next screen
            currentQuestionIndex += 1
        }
    }
}


struct SmokingSurveyViewV2_Previews: PreviewProvider {
    static var previews: some View {
        SmokingSurveyViewV2()
    }
}

//
//extension SmokingSurveyView {
//    func startHeartRateQuery() {
//        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
//
//        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { query, samples, _, _, error in
//            self.handleHeartRateSamples(samples)
//        }
//
//        query.updateHandler = { query, samples, _, _, error in
//            self.handleHeartRateSamples(samples)
//        }
//
//        healthStore.execute(query)
//    }
//
//    private func handleHeartRateSamples(_ samples: [HKSample]?) {
//        guard let samples = samples as? [HKQuantitySample] else { return }
//
//        for sample in samples {
//            let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
//            let heartRate = sample.quantity.doubleValue(for: heartRateUnit)
//            print("Heart rate: \(heartRate) BPM")
//
//            DispatchQueue.main.async {
//                self.heartRate = heartRate
//            }
//        }
//    }
//
//    func fetchHRVData(completion: @escaping (Double?) -> Void) {
//        let hrvType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
//        let now = Date()
//        let startOfDay = Calendar.current.startOfDay(for: now)
//        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
//
//        let query = HKSampleQuery(sampleType: hrvType, predicate: predicate, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { _, results, error in
//            if let result = results?.first as? HKQuantitySample {
//                let hrv = result.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli))
//                completion(hrv)
//            } else {
//                if let error = error {
//                    print("Error fetching HRV: \(error.localizedDescription)")
//                }
//                completion(nil)
//            }
//        }
//
//        healthStore.execute(query)
//    }
//
//    // Simple interpretation of stress based on HRV
//    func stressLevel(for hrv: Double) -> String {
//        switch hrv {
//        case ..<30:
//            return "High Stress"
//        case 30..<50:
//            return "Moderate Stress"
//        default:
//            return "Low Stress"
//        }
//    }
//
//    func enableBackgroundDelivery() {
//        healthStore.enableBackgroundDelivery(for: HKObjectType.quantityType(forIdentifier: .heartRate)!, frequency: .immediate) { success, error in
//            if success {
//                print("Background delivery enabled for heart rate")
//            } else if let error = error {
//                print("Error enabling background delivery: \(error.localizedDescription)")
//            }
//        }
//
//        healthStore.enableBackgroundDelivery(for: HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!, frequency: .immediate) { success, error in
//            if success {
//                print("Background delivery enabled for HRV")
//            } else if let error = error {
//                print("Error enabling background delivery for HRV: \(error.localizedDescription)")
//            }
//        }
//    }
//}

//
//VStack(alignment: .leading, spacing: 20) {
//    Color.clear
//
//    VStack {
//        Text("Heart Rate: \(Int(heartRate)) BPM")
//            .font(.largeTitle)
//            .padding()
//
//        Button(action: {
//            startHeartRateQuery()
//        }) {
//            Text("Start Monitoring Heart Rate")
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//        }
//    }
//
//    VStack {
//        if let hrv = hrvValue {
//            Text("Heart Rate Variability: \(hrv, specifier: "%.2f") ms")
//                .font(.largeTitle)
//                .padding()
//            Text(stressLevel(for: hrv))
//                .font(.title)
//                .padding()
//        } else {
//            Text("Fetching HRV...")
//                .font(.largeTitle)
//                .padding()
//        }
//
//        Button(action: {
//            fetchHRVData { hrv in
//                DispatchQueue.main.async {
//                    self.hrvValue = hrv
//                }
//            }
//        }) {
//            Text("Get Latest HRV")
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//        }
//    }
//}
//.padding()
