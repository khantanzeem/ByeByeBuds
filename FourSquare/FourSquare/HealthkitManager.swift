//
//  HealthKitManager.swift
//  FourSquare
//
//  Created by Mindstix on 25/09/24.
//

import Foundation
import HealthKit

class HealthKitManager {
    let healthStore = HKHealthStore()
    
    func requestAuthorization() {
        // Define the types of data you want to read and write
        let readTypes: Set = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        ]
        
        // Request permission from the user
        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            if success {
                print("Authorization succeeded")
            } else {
                if let error = error {
                    print("Authorization failed with error: \(error.localizedDescription)")
                }
            }
        }
    }
}

