//
//  AssesmentView.swift
//  FourSquare
//
//  Created by Abdul Khan on 24/09/24.
//

import SwiftUI
import HealthKit

struct SmokingSurveyView: View {
    @State private var name: String = ""
    @State private var doYouSmoke: Bool = false
    @State private var smokingDays: String = ""
    @State private var dailyUrge: String = ""
    @State private var quitAttempts: String = ""
    @State private var reasonsToQuit: String = ""
    @State private var goTOCustomTabBar: Bool = false
    
    
    @State private var hrvValue: Double? = nil
    @State private var heartRate: Double = 0.0
    let healthKitManager = HealthKitManager()
    let healthStore = HKHealthStore()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationLink("", isActive: $goTOCustomTabBar) {
                // Questions View
                CustomTabBarView()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Color.clear
                    
                    VStack {
                        Text("Heart Rate: \(Int(heartRate)) BPM")
                            .font(.largeTitle)
                            .padding()
                        
                        Button(action: {
                            startHeartRateQuery()
                        }) {
                            Text("Start Monitoring Heart Rate")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    VStack {
                        if let hrv = hrvValue {
                            Text("Heart Rate Variability: \(hrv, specifier: "%.2f") ms")
                                .font(.largeTitle)
                                .padding()
                            Text(stressLevel(for: hrv))
                                .font(.title)
                                .padding()
                        } else {
                            Text("Fetching HRV...")
                                .font(.largeTitle)
                                .padding()
                        }
                        
                        Button(action: {
                            fetchHRVData { hrv in
                                DispatchQueue.main.async {
                                    self.hrvValue = hrv
                                }
                            }
                        }) {
                            Text("Get Latest HRV")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
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
                //                .frame(width: UIScreen.main.bounds.width - 40)
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
        .onAppear {
//            self.enableBackgroundDelivery()
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


extension SmokingSurveyView {
    func startHeartRateQuery() {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        
        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { query, samples, _, _, error in
            self.handleHeartRateSamples(samples)
        }
        
        query.updateHandler = { query, samples, _, _, error in
            self.handleHeartRateSamples(samples)
        }
        
        healthStore.execute(query)
    }
    
    private func handleHeartRateSamples(_ samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else { return }
        
        for sample in samples {
            let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
            let heartRate = sample.quantity.doubleValue(for: heartRateUnit)
            print("Heart rate: \(heartRate) BPM")
            
            DispatchQueue.main.async {
                self.heartRate = heartRate
            }
        }
    }
    
    func fetchHRVData(completion: @escaping (Double?) -> Void) {
        let hrvType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: hrvType, predicate: predicate, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { _, results, error in
            if let result = results?.first as? HKQuantitySample {
                let hrv = result.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli))
                completion(hrv)
            } else {
                if let error = error {
                    print("Error fetching HRV: \(error.localizedDescription)")
                }
                completion(nil)
            }
        }
        
        healthStore.execute(query)
    }
    
    // Simple interpretation of stress based on HRV
    func stressLevel(for hrv: Double) -> String {
        switch hrv {
        case ..<30:
            return "High Stress"
        case 30..<50:
            return "Moderate Stress"
        default:
            return "Low Stress"
        }
    }
    
    func enableBackgroundDelivery() {
        healthStore.enableBackgroundDelivery(for: HKObjectType.quantityType(forIdentifier: .heartRate)!, frequency: .immediate) { success, error in
            if success {
                print("Background delivery enabled for heart rate")
            } else if let error = error {
                print("Error enabling background delivery: \(error.localizedDescription)")
            }
        }
        
        healthStore.enableBackgroundDelivery(for: HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!, frequency: .immediate) { success, error in
            if success {
                print("Background delivery enabled for HRV")
            } else if let error = error {
                print("Error enabling background delivery for HRV: \(error.localizedDescription)")
            }
        }
    }
}
