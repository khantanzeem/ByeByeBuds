//
//  SmokeFreeView.swift
//  FourSquare
//
//  Created by Abdul Khan on 26/09/24.
//

import SwiftUI

struct SmokeFreeView: View {
    @Binding var goToCustomTabBar: Bool
    @State var totalSavingCigrattes: String = "0"
    @State var totalSavingMoney: String = "0"
    
    var body: some View {
        VStack {
            Spacer()
            
            // Top Label
            Text("Your first month smoke-free")
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 40)
            
            // Cigarettes avoided and money saved section
            HStack(spacing: 40) {
                // Cigarettes avoided
                VStack {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.orange)
                    
                    Text("\(totalSavingCigrattes)")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("cigarettes avoided")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                // Money saved
                VStack {
                    Image(systemName: "indianrupeesign.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                    
                    Text("₹\(totalSavingMoney)")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("money saved")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }
            .padding(.bottom, 40)
            
            // Body improvement message
            Text("Your body will have improved in 4 different areas according to the WHO")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            
            Spacer()
            
            Button(action: {
                UserDefaults.standard.set(true, forKey: "assesmentAttempted")
                goToCustomTabBar = true
            }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "ff575e"))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding()
        .onAppear {
            let cigaretteCount = UserDefaults.standard.string(forKey: "question3")
            let intValueCigarett = Int(cigaretteCount ?? "0")
            let intTotalSavingCigrattes = (intValueCigarett ?? 0) * 30
            totalSavingCigrattes = String(intTotalSavingCigrattes)
            
            let periceOfCigarette = UserDefaults.standard.string(forKey: "question4")
            let intValueSavings = Int(periceOfCigarette ?? "0")
            let totalSavingMoney1 = (intValueSavings ?? 0) * (intValueCigarett ?? 0) * 30
            totalSavingMoney = String(totalSavingMoney1)
            
        }
    }
}

struct SmokeFreeView_Previews: PreviewProvider {
    static var previews: some View {
        SmokeFreeView(goToCustomTabBar: .constant(false))
    }
}
