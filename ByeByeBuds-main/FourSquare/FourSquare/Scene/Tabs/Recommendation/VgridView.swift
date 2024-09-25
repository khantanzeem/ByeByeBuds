//
//  Vgrid.swift
//  FourSquare
//
//  Created by Mindstix on 26/09/24.
//

import SwiftUI

struct VGridView: View {
    // Define a flexible grid layout with 3 columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let recommendedImageArray: [String] = ["reading","mindfulness","eating","gaming","support","community","running"]
    let recommendedImageContent: [String] = ["Reading helps you to get calm","Mindfulness helps you to control heart rate","Try eating something","try gaming","Reach out to experts","Hear from someone just like you","Running helps you to reduce stress"]
    
    var body: some View {
        ScrollView {
            ZStack (alignment: .bottom){
                Image("running")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                    .cornerRadius(9)
                    .padding(.bottom, 10)
                Text("Running helps you to reduce stress")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.trailing, 80)
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 200)
            .padding(.top, 5)
            
            LazyVGrid(columns: columns, spacing: 5) {
                // Create 9 white tiles with slightly different heights
                ForEach(0..<recommendedImageArray.count) { index in
                    let tileHeight = CGFloat(180 + (index % 3) * 20) // Varying height
                    Image(recommendedImageArray[index])
                        .resizable()
                        .frame(height: tileHeight) // Vary height dynamically
                        .cornerRadius(9)
                        .overlay(
                            Text(recommendedImageContent[index])
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.horizontal, 10)
                                .padding(.top, 40)
                        )
                        .shadow(radius: 5) // Shadow effect for tiles
                    
                }
            }
            .padding()
            .padding(.bottom, 90)
        }
    }
}

struct VGridView_Previews: PreviewProvider {
    static var previews: some View {
        VGridView()
    }
}
