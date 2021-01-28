//
//  Clock.swift
//  myClockApp
//
//  Created by Ryoma Usui on 2021/01/18.
//

import SwiftUI

struct ClockView: View {
    @State var clockSize: CGFloat
    var body: some View {
        ZStack {
            ClockDial(clockSize: clockSize).opacity(0.5)
            ClockHandsView(clockSize: clockSize)
        }
        .frame(width: clockSize * 2, height: clockSize * 2, alignment: .topLeading)
        .padding()
        .background(Color.clear)
        //        .environment(\.colorScheme, .light)
        .environment(\.colorScheme, .dark)
        //        .opacity(0.9)
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(clockSize: 90)
    }
}

struct ClockHand: View {
    @State var clockSize: Int
    @State var color: Color
    @State var handwidth: CGFloat
    @State var handlength: CGFloat
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: clockSize, y: clockSize))
            path.addLine(to: CGPoint(x: clockSize, y: clockSize - (clockSize * Int(handlength)/100)))
        }
        .stroke(color, lineWidth: handwidth)
    }
}

struct ClockHandsView: View {
    @State var hour = Calendar.current.component(.hour, from: Date())
    @State var minute = Calendar.current.component(.minute, from: Date())
    @State var second = Calendar.current.component(.second, from: Date())
    @State var clockSize: CGFloat
    let currentTime = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            ClockHand(clockSize: Int(clockSize), color: Color.green, handwidth: 4, handlength: 50).rotationEffect(.degrees(Double(hour * 30) + Double(minute) * 0.5))
            ClockHand(clockSize: Int(clockSize), color: Color.blue, handwidth: 3, handlength: 75).rotationEffect(.degrees(Double(minute) * 6 + Double(second) * 0.1))
            ClockHand(clockSize: Int(clockSize), color: Color.red, handwidth: 2, handlength: 90).rotationEffect(.degrees(Double(second * 6)))
        }
        .onReceive(currentTime) { _ in
            self.hour = Calendar.current.component(.hour, from: Date())
            self.minute = Calendar.current.component(.minute, from: Date())
            self.second = Calendar.current.component(.second, from: Date())
        }.frame(width: clockSize * 2, height: clockSize * 2, alignment: .center)
    }
}

struct ClockDial: View {
    @State var clockSize: CGFloat
    var body: some View {
        ZStack{
            Circle().fill(Color(#colorLiteral(red: 0.8102077842, green: 0.1685749888, blue: 0.07550816983, alpha: 0.02372897401)))
            ForEach(0..<60) {i in
                ClockHand(clockSize: Int(clockSize), color: .white, handwidth: 1, handlength: 5)
                    .offset(x: 0, y: clockSize)
                    .rotationEffect(.degrees(Double(6 * i)))
            }
            ForEach(0..<12) {i in
                ClockHand(clockSize: Int(clockSize), color: .white, handwidth: 1, handlength: 20)
                    .offset(x: 0, y: clockSize)
                    .rotationEffect(.degrees(Double(30 * i)))
            }
        }
    }
}
