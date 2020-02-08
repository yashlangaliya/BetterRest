//
//  ContentView.swift
//  BetterRest
//
//  Created by stl-037 on 06/02/20.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var cupsOfCoffee = 1
    @State private var wakeUp: Date = defaultWakeUpTime
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var timeToSleep: String {
        let sleepCalculator = SleepCalculator()
        let dateComps = Calendar.current.dateComponents([.hour, .minute], from: self.wakeUp)
        let wakeUpHour = Double(dateComps.hour ?? 0) * 3600.0
        let wakeUpMinute = Double(dateComps.minute ?? 0) * 60.0
        
        let prediction = try? sleepCalculator.prediction(wake: wakeUpHour+wakeUpMinute, estimatedSleep: self.sleepAmount, coffee: Double(self.cupsOfCoffee))
            let dateFormate = DateFormatter()
            dateFormate.timeStyle = .short
        return "\(dateFormate.string(from:(wakeUp-(prediction?.actualSleep ?? 0))))"
    }
    
    
    static var defaultWakeUpTime: Date {
        var comp = DateComponents()
        comp.hour = 7
        comp.minute = 0
        return Calendar.current.date(from: comp) ?? Date()
    }
    
    var barItem: some View {
        return Button(action: self.calculateGoToSleepTime) {
            Text("Calculate")
        }
    }
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("When do you want to wakeup?")) {
                    DatePicker(selection: $wakeUp, displayedComponents: .hourAndMinute) {
                        Text("Please enter Time")
                    }
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("How much sleep you need?")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section(header: Text("How much Coffee you drink?")) {
                    //                    Stepper(value: $cupsOfCoffee, in: 1...20) {
                    //                        Text("\(cupsOfCoffee) \(cupsOfCoffee == 1 ? "Cup" : "Cups")")
                    //                    }
                    Picker("How much Coffee you drink?", selection: $cupsOfCoffee) {
                        ForEach(1...20, id: \.self) {
                            Text("\($0) \($0 == 1 ? "Cup" : "Cups")")
                        }
                    }
                }
                Section(header: Text("You should Sleep by...")) {
                    HStack {
                        Spacer()
                        Text(timeToSleep)
                            .font(.title)
                            .foregroundColor(.blue)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Better Rest", displayMode: .inline)
            //.navigationBarItems(trailing: barItem)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func calculateGoToSleepTime() {
        let sleepCalculator = SleepCalculator()
        let dateComps = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let wakeUpHour = Double(dateComps.hour ?? 0) * 3600.0
        let wakeUpMinute = Double(dateComps.minute ?? 0) * 60.0
        do {
            let prediction = try sleepCalculator.prediction(wake: wakeUpHour+wakeUpMinute, estimatedSleep: sleepAmount, coffee: Double(cupsOfCoffee))
            let dateFormate = DateFormatter()
            dateFormate.timeStyle = .short
            alertTitle = "You should Sleep by..."
            alertMessage = "\(dateFormate.string(from:(wakeUp-prediction.actualSleep)))"
        } catch  {
            alertTitle = "Error"
            alertMessage = "Trouble calculating your bedtime..."
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
