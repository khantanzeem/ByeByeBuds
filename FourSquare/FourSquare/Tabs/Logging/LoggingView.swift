//
//  LoggingView.swift
//  FourSquare
//
//  Created by Abdul Khan on 25/09/24.
//

import SwiftUI

struct LoggingView: View {
    @State var yesSelected: Bool = false
    @State var noSelected: Bool = false
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
            ZStack() {
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "##131313"))
                            .frame(width: UIScreen.main.bounds.width,height: 280)
                            .cornerRadius(20)
                        VStack {
                            
                            HStack {
                                Text("Logging")
                                    .font(.title)
                                    .foregroundStyle(Color.white)
                                    .bold()
                                Spacer()
                            }
                            .padding(.horizontal,20)
                            .padding(.top, 40)
                            
                            VStack {
                                Text("Did you smoke Today ?")
                                    .foregroundStyle(Color.white)
                                    .font(.largeTitle)
                                
                                HStack(spacing : 60) {
                                    Button(action: {
                                        noSelected = false
                                        yesSelected = true
                                    }, label: {
                                        HStack {
                                            Text("Yes")
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 80, height: 40)
                                        .background(Color(hex: "#273270"))
                                        .cornerRadius(24)
                                    })
                                    
                                    Button(action: {
                                        yesSelected = false
                                        noSelected = true
                                    }, label: {
                                        HStack {
                                            Text("No")
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 80, height: 40)
                                        .background(Color(hex: "#273270"))
                                        .cornerRadius(24)
                                    })
                                }
                                .padding(.top)
                            }
                            .padding(.top, 26)
                        }
                    }
                    if yesSelected {
                        ScrollView {
                            VStack(alignment: .leading) {
                                VStack {
                                    Text("How many cigarettes did you smoke?")
                                        .foregroundStyle(.black)
                                        .font(.headline)
                                    
                                    TextField("Enter number", text: .constant(""))
                                        .foregroundColor(.black)
                                        .padding()
                                        .keyboardType(.numberPad)
                                        .frame(height: 40)
                                        .background(Color(hex: "#9ca8fc"))
                                        .cornerRadius(12)
                                }
                                .padding()
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "#273270")))
                            .background(Color.white)
                            .cornerRadius(12)
                            
                            VStack(alignment: .leading) {
                                VStack {
                                    Text("How many times did you take today?")
                                        .foregroundStyle(.black)
                                        .font(.headline)
                                    
                                    TextField("Enter number", text: .constant(""))
                                        .foregroundColor(.black)
                                        .padding()
                                        .keyboardType(.numberPad)
                                        .frame(height: 40)
                                        .background(Color(hex: "#9ca8fc"))
                                        .cornerRadius(12)
                                }
                                .padding()
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "#273270")))
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        
                        Spacer()
                        Button(action: {
//                            Action on submit
                        }, label: {
                            HStack {
                                Text("Submit")
                                    .foregroundStyle(.white)
                            }
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .background(Color(hex: "#273270"))
                            .cornerRadius(24)
                        })
                        .padding(.bottom, 120)
                    }
                    if noSelected {
                        ZStack {
                            Image("quitSmoking")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                            Text("Congratulations")
                                .font(.title)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .padding(.top, 40)
    }
}

#Preview {
    LoggingView()
}
