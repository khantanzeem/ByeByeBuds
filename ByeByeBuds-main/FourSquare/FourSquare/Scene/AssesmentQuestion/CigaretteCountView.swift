//
//  CigaretteCountView.swift
//  FourSquare
//
//  Created by Abdul Khan on 26/09/24.
//

import SwiftUI

struct CigaretteCountView: View {
    @State private var cigaretteCount: String = "0"
    var question: String
    var questionID: String
    var nextAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(question)
                .foregroundStyle(.white)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
                Text(cigaretteCount)
                    .foregroundStyle(.white)
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .padding(.bottom, 32)
            
            Spacer()
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    NumericKeyButton(label: "7", action: { appendNumber("7") })
                    NumericKeyButton(label: "8", action: { appendNumber("8") })
                    NumericKeyButton(label: "9", action: { appendNumber("9") })
                }
                HStack(spacing: 16) {
                    NumericKeyButton(label: "4", action: { appendNumber("4") })
                    NumericKeyButton(label: "5", action: { appendNumber("5") })
                    NumericKeyButton(label: "6", action: { appendNumber("6") })
                }
                HStack(spacing: 16) {
                    NumericKeyButton(label: "1", action: { appendNumber("1") })
                    NumericKeyButton(label: "2", action: { appendNumber("2") })
                    NumericKeyButton(label: "3", action: { appendNumber("3") })
                }
                HStack(spacing: 16) {
                    NumericKeyButton(label: "0", action: { appendNumber("0") })
                    NumericKeyButton(label: "0", action: { appendNumber("0") })
                    NumericKeyButton(label: "⌫", action: { deleteLastDigit() })
                }
            }
            .padding(.bottom, 32)
            
            Button(action: {
                UserDefaults.standard.set(cigaretteCount, forKey: questionID)
                nextAction()
            }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(cigaretteCount != "0" ? Color(hex: "#ff575e") : Color.gray)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .disabled(cigaretteCount == "0")
        }
        .padding()
        .onAppear {
            cigaretteCount = UserDefaults.standard.string(forKey: questionID) ?? ""
        }
    }
    
    private func appendNumber(_ number: String) {
        if cigaretteCount == "0" {
            cigaretteCount = number
        } else {
            cigaretteCount += number
        }
    }
    
    private func deleteLastDigit() {
        if !cigaretteCount.isEmpty {
            cigaretteCount.removeLast()
            if cigaretteCount.isEmpty {
                cigaretteCount = "0"
            }
        }
    }
}


// Custom numeric keypad button
struct NumericKeyButton: View {
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(Color(hex: "#3fda9b"))
                .cornerRadius(8)
        }
    }
}

//struct CigaretteCountView_Previews: PreviewProvider {
//    static var previews: some View {
//        CigaretteCountView()
//    }
//}

