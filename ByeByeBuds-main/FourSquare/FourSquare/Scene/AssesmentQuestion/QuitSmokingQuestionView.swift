//
//  QuitSmokingQuestionView.swift
//  FourSquare
//
//  Created by Abdul Khan on 25/09/24.
//


import SwiftUI

struct QuitSmokingQuestionView: View {
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    var nextAction: () -> Void
    var questionID: String

    var body: some View {
        VStack {
            Spacer()
            
            Text("When did you quit smoking?")
                .foregroundStyle(.white)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            Text("If you haven't quit yet, pick when you will do it")
                .font(.subheadline)
                .foregroundColor(Color(hex: "#fbfafb"))
                .padding(.bottom, 32)
            
            Text("\(formattedDate()) at \(formattedTime())")
                .foregroundStyle(.white)
                .font(.title3)
                .fontWeight(.medium)
                .padding(.bottom, 24)
            
            HStack(spacing: 16) {
                Button(action: {
                    self.showDatePicker.toggle()
                }) {
                    Text("Pick date")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#ffc641"))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    self.showTimePicker.toggle()
                }) {
                    Text("Pick time")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#ffc641"))
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, 32)
            
            Image(systemName: "calendar.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                UserDefaults.standard.set(selectedDate.timeIntervalSince1970, forKey: questionID)
                nextAction()
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
        .sheet(isPresented: $showDatePicker) {
            DatePickerView(date: $selectedDate)
        }
        .sheet(isPresented: $showTimePicker) {
            TimePickerView(date: $selectedDate)
        }
        .onAppear {
            if let savedDate = UserDefaults.standard.object(forKey: questionID) as? TimeInterval {
                            selectedDate = Date(timeIntervalSince1970: savedDate)
                        }
        }
    }

    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: selectedDate)
    }

    private func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: selectedDate)
    }
}


// DatePickerView Component
struct DatePickerView: View {
    @Binding var date: Date
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            DatePicker("Pick a date", selection: $date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            Button("Done") {
                dismiss()  // Dismiss the sheet when "Done" is tapped
            }
            .padding()
        }
        .onChange(of: date) { _ in
            dismiss()  // Automatically dismiss when date is selected
        }
    }
}

// TimePickerView Component
struct TimePickerView: View {
    @Binding var date: Date
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            DatePicker("Pick a time", selection: $date, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            Button("Done") {
                dismiss()  // Dismiss the sheet when "Done" is tapped
            }
            .padding()
        }
        .onChange(of: date) { _ in
            dismiss()  // Automatically dismiss when time is selected
        }
    }
}

//struct QuitSmokingQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuitSmokingQuestionView()
//    }
//}
