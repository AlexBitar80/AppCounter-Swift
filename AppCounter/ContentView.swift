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
    
    var selectedDate = Date()
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            // vai ser disparado a cada um segundo
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .day, .month, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            
            let selectedComponents = calendar.dateComponents([.year, .day, .month, .hour, .minute, .second], from: self.selectedDate)
            
            var eventDateComponent = DateComponents()
            
            eventDateComponent.year = selectedComponents.year
            eventDateComponent.month = selectedComponents.month
            eventDateComponent.day = selectedComponents.day
            eventDateComponent.hour = selectedComponents.hour
            eventDateComponent.minute = selectedComponents.minute
            eventDateComponent.second = selectedComponents.second
        
            let eventDate = calendar.date(from: eventDateComponent)
            
            let timeLeft = calendar.dateComponents([ .day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            if (timeLeft.second! >= 0) {
                self.days = timeLeft.day ?? 0
                self.hours = timeLeft.hour ?? 0
                self.minutes = timeLeft.minute ?? 0
                self.seconds = timeLeft.second ?? 0
            }
        }
    }
}

struct ContentView: View {
    @StateObject var couter = Couter()
    
    var body: some View {
        VStack() {
            Text("Selecione uma data:")
                .font(.title)
                .multilineTextAlignment(.center)
            DatePicker(selection: $couter.selectedDate, in: Date()..., displayedComponents: [.hourAndMinute, .date], label: {
            })
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            HStack {
                Text("\(couter.days) dias")
                Text("\(couter.hours) horas")
                Text("\(couter.minutes) min")
                Text("\(couter.seconds) seg")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
