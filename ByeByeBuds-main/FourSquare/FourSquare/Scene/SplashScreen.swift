//
//  SplashScreen.swift
//  FourSquare
//
//  Created by Mindstix on 25/09/24.
//
import SwiftUI

struct SplashScreen: View {
    @State var navigateToNext: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    LottieView(lottieFile: "lottie1")
                        .frame(width: UIScreen.main.bounds.width - 20, height: 350)
                    Text("Chain Breaker")
                        .font(.title)
                }
                NavigationLink("", isActive: $navigateToNext) {
                    // Questions View
                    if UserDefaults.standard.bool(forKey: "assesmentAttempted") {
                        CustomTabBarView()
                    } else {
                        AssessmentLandingView()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            .padding(.top, 40)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    navigateToNext = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
