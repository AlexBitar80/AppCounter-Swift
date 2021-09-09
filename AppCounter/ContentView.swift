//
//  ContentView.swift
//  AppCounter
//
//  Created by João Alexandre on 09/09/21.
//

import SwiftUI

class Couter: ObservableObject {
    @Published var days = 0
    @Published var hours = 0
    @Published var minutes = 0
    @Published var seconds = 0
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            // vai ser disparado a cada um segundo
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .day, .month, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            
            var eventDateComponent = DateComponents()
            
            eventDateComponent.year = 2022
            eventDateComponent.month = 8
            eventDateComponent.day = 10
            eventDateComponent.hour = 21
            eventDateComponent.minute = 10
            eventDateComponent.second = 20
        
            let eventDate = calendar.date(from: eventDateComponent)
            
            let timeLeft = calendar.dateComponents([ .day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            self.days = timeLeft.day ?? 0
            self.hours = timeLeft.hour ?? 0
            self.minutes = timeLeft.minute ?? 0
            self.seconds = timeLeft.second ?? 0
        }
    }
}

struct ContentView: View {
    @StateObject var couter = Couter()
    
    var body: some View {
        VStack {
            HStack {
                Text("\(couter.days) dias")
                Text("\(couter.hours) horas")
                Text("\(couter.minutes) min")
                Text("\(couter.seconds) seg")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
