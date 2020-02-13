//
//  ContentView.swift
//  TimerKit
//
//  Created by Nien Lam on 2/13/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // Time remaining in seconds. The source of truth.
    @State var timeRemaining = 60

    // Flag for timer state.
    @State var timerIsRunning = false

    // Timer gets called every second.
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            // TimeDisplay view with data bindings.
            // NOTE: Syntax used for data bindings.
            TimeDisplay(timeRemaining: $timeRemaining)

            Button(action: {
                // Toggle timer on/off.
                self.timerIsRunning.toggle()
                
                // If timer is not running, reset back to 60
                if !self.timerIsRunning {
                    self.timeRemaining = 60
                }
            }) {
                // Start / Stop Button
                Text(timerIsRunning ? "Reset" : "Start")
                    .font(.system(size: 30))
                    .frame(width: 160, height: 60)
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(30)
            }
            
            Text("Tap on time to increase")
                .foregroundColor(.black)
                .padding()
        }
        .onReceive(timer) { _ in
            // Block gets called when timer updates.

            // If timeRemaining and timer is running, count down.
            if self.timeRemaining > 0 && self.timerIsRunning {
                self.timeRemaining -= 1
                
                print("Time Remaining:", self.timeRemaining)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
