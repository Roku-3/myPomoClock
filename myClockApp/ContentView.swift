//
//  ContentView.swift
//  myClockApp
//
//  Created by Ryoma Usui on 2021/01/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //        Text("Hello, !")
        //            .frame(maxWidth: .infinity, maxHeight: .infinity)
        let clockSize: CGFloat = 90
        //        WindowSettings()
        ZStack{
            PomodoroView(clockSize: clockSize, workTime: 15, restTime: 1)
            ClockView(clockSize: clockSize)
//            ClockDial(clockSize: clockSize)
//            ClockHandsView(clockSize: clockSize)
        }
        .shadow(radius: 5)
        .padding(10)
//        .frame(width: clockSize * 2, height: clockSize * 2, alignment: .topLeading)
//        .padding()
//        .background(Color.clear)
////        .environment(\.colorScheme, .light)
//        .environment(\.colorScheme, .dark)
//        //        .opacity(0.9)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



