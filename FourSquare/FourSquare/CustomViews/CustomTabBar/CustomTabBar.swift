//
//  CustomTabBar.swift
//  FourSquare
//
//  Created by Abdul Khan on 24/09/24.
//

import SwiftUI

struct CustomTabBarView: View {
    @State private var selectedTab: TabBarItem = .home
    @State var fromDashboard: Bool = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                manageTabView
                setUpCustomTabBar
                    .padding(.bottom)
            }
            .ignoresSafeArea()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    var manageTabView: some View {
        TabView(selection: $selectedTab) {
            switch selectedTab {
            case .home:
                ZStack(alignment: .bottom) {
                    if true {
                        // Background color
                        Color(hex: "#697cfb")
                            .blur(radius: 20)
                            .frame(height: UIScreen.main.bounds.height, alignment: .top)
                            .ignoresSafeArea()
                    }
                    HomeScreenView()

                }
            case .logging:
                ZStack(alignment: .bottom) {
                    if true {
                        // Background color
                        Color(hex: "#697cfb")
                            .blur(radius: 20)
                            .frame(height: UIScreen.main.bounds.height, alignment: .top)
                            .ignoresSafeArea()
                    }
                    LoggingView()

                }
            case .recommendedSection:
                ZStack(alignment: .bottom) {
                    if true {
                        // Background color
                        Color(hex: "#697cfb")
                            .blur(radius: 20)
                            .frame(height: UIScreen.main.bounds.height, alignment: .top)
                            .ignoresSafeArea()
                    }
                    RecommendationView()

                }
            }
        }
        .accentColor(.black)
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }
    }

    var setUpCustomTabBar: some View {
        VStack {
            HStack(alignment: .center, spacing: 60) {
                TabBarButton(tab: .logging, selectedTab: $selectedTab)
                TabBarButton(tab: .home, selectedTab: $selectedTab)
                TabBarButton(tab: .recommendedSection, selectedTab: $selectedTab)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 90)
        .background(Color.white)
//        .cornerRadius(16, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.1),
                radius: 3,
                x: 0,
                y: -2)
    }
}


struct TabBarButton: View {
    let tab: TabBarItem
    @Binding var selectedTab: TabBarItem
    var body: some View {
        VStack {
            Button(action: {
                //            SelectedTabManager.shared.selectedTab = tab
                selectedTab = tab
            }, label: {
                if selectedTab == tab {
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "#273270"))
                            .cornerRadius(30)
                            .blur(radius: 0.5)
                            .frame(width: 95, height: 65)
                        tab.selectedImage
                            .resizable()
                            .foregroundColor(Color.white)
                            .frame(width: 25, height: 25)
                    }
                } else {
                    tab.image
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30)
                }
            })
        }
        .frame(width: 80)
    }
}


enum TabBarItem: Hashable {
    case recommendedSection
    case logging
    case home

    var title: String {
        switch self {
        case .recommendedSection:
            return "Recommended"
        case .home:
            return "Home"
        case .logging:
            return "Logging"
        }
    }

    var image: Image {
        switch self {
        case .recommendedSection:
            return Image(systemName: "book")
        case .home:
            return Image(systemName: "house")
        case .logging:
            return Image(systemName: "pencil")
        }
    }

    var selectedImage: Image {
        switch self {
        case .recommendedSection:
            return Image(systemName: "book")
        case .home:
            return Image(systemName: "house")
        case .logging:
            return Image(systemName: "pencil")
        }
    }
}


struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}



extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a: UInt64
        let r: UInt64
        let g: UInt64
        let b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
