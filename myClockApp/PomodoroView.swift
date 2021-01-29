//
//  PomodoroView.swift
//  myClockApp
//
//  Created by Ryoma Usui on 2021/01/18.
//

import SwiftUI

struct PomodoroView: View {
    @State var clockSize: CGFloat
    @State var workTime: Int
    @State var restTime: Int
    @State var start = false
    @State var to : CGFloat = 0.6
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            PomodoroRing(clockSize: clockSize, workTime: 15, restTime: 1)
        }
    }
}

struct PomodoroRing: View {
    @State var clockSize: CGFloat
    @State var workTime: Int
    @State var restTime: Int
    @State var start = false
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @ObservedObject var countDownManager = CountDownManager(workingMin: 18, restMin: 2)

    var body: some View {
        ZStack{
            Circle()
                .fill(Color.black.opacity(0.1))
                .frame(width: clockSize * 2, height: clockSize * 2, alignment: .center)
            
            Circle()
                .stroke(Color.black.opacity(0.2), style: StrokeStyle(lineWidth: 30, lineCap: .round))
                .frame(width: clockSize * 2, height: clockSize * 2, alignment: .center)
            
            if countDownManager.mode == .work{
                Circle()
                    .trim(from: 0, to: CGFloat(countDownManager.minutesElapsed) / 18)
                    .stroke(Color(#colorLiteral(red: 0.9041073322, green: 0.06239562482, blue: 0.960264504, alpha: 0.7663437201)), style: StrokeStyle(lineWidth: 30, lineCap: .butt))
                    .frame(width: clockSize * 2, height: clockSize * 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .rotationEffect(.init(degrees: -90))
//                .frame(width: clockSize * 2, height: clockSize * 2, alignment: .center)
                Button(action: {self.countDownManager.stop()})
                {
                    Text("STOP")
                        .frame(maxWidth: 100, maxHeight: 100)
                }
                .buttonStyle(RedButtonStyle())
            }else if countDownManager.mode == .rest {
                Circle()
                    .trim(from: 0, to: CGFloat(countDownManager.minutesElapsed) / 2)
                    .stroke(Color(#colorLiteral(red: 0.1297547519, green: 0.7601366043, blue: 0.9960772395, alpha: 0.6547062673)), style: StrokeStyle(lineWidth: 30, lineCap: .butt))
                    .frame(width: clockSize * 2, height: clockSize * 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .rotationEffect(.init(degrees: -90))
            }else if countDownManager.mode == .stopped {
                Button(action: {self.countDownManager.start()})
                {
                    Text("START")
                        .frame(maxWidth: 100, maxHeight: 100)
                }
                .buttonStyle(RedButtonStyle())
            }

//            Button(action: {self.countDownManager.start()}){
//            }
//            .frame(width: 100, height: 100)

//            VStack {
//                Text(String(format: "%.2f", countDownManager.minutesElapsed))
//                    .font(.title)
//                    .foregroundColor(.red)
//
//                if countDownManager.mode == .stopped{
//                    Button(action: {self.countDownManager.start()}, label: {
//                        Text("let's work!!")
//                            .foregroundColor(.red)
//                    })
//                }
//                if countDownManager.mode == .work{
//                    Button(action: {self.countDownManager.stop()}, label: {
//                        Text("stop")
//                            .foregroundColor(.red)
//                    })
//                }
                
//                if(countDownManager.mode == .prepare){
//                    Text("prepare")
//                        .foregroundColor(.red)
//                }
//                if(countDownManager.mode == .work){
//                    Text("work")
//                        .foregroundColor(.red)
//                }
//                if(countDownManager.mode == .rest){
//                    Text("rest")
//                        .foregroundColor(.red)
//                }
//                if(countDownManager.mode == .stopped){
//                    Text("stopped")
//                        .foregroundColor(.red)
//                }
//            }
        }
        .padding()
    }
}

struct RedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color(#colorLiteral(red: 0.9884135127, green: 0.1310118437, blue: 0.02432728559, alpha: 0.3970465628)): Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3538216312)))
            .background(configuration.isPressed ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3503787501)) : Color(#colorLiteral(red: 0.9884135127, green: 0.1310118437, blue: 0.02432728559, alpha: 0.3970465628)))
            .cornerRadius(1000)
            .padding()
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView(clockSize: 90, workTime: 15, restTime: 1)
    }
}

