//
//  CountDownManager.swift
//  myClockApp
//
//  Created by Ryoma Usui on 2021/01/17.
//

import Foundation
import SwiftUI

class CountDownManager: ObservableObject{
    let workingMin: Int
    let restMin: Int
    init(workingMin: Int, restMin: Int) {
        self.workingMin = workingMin
        self.restMin = restMin
    }

    enum pomoState {
//        case prepare
        case work
        case rest
        case stopped
    }
    
    @Published var mode: pomoState = .stopped
    
    @Published var minutesElapsed = 0.0
    var timer = Timer()
//    @Published var prepareTime = Calendar.current.component(.second, from: Date())
//    var prepareTimer: Timer {
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
//            self.prepareTime = Calendar.current.component(.second, from: Date())
//        }
//    }
    
//    func prepare() {
//        mode = .prepare
//        self.start()
//        
//    }
    
    func start() {
        mode = .work
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
//            if(self.mode == .prepare){
//                if(self.prepareTime == 0){
//                    self.mode = .work
//                }
            if(self.mode == .work){
                if(self.minutesElapsed < Double(self.workingMin)){
                    self.minutesElapsed += 0.01
                }else{
                    self.minutesElapsed = 0.0
                    self.mode = .rest
                }
            }else if(self.mode == .rest){
                if(self.minutesElapsed < Double(self.restMin)){
                    self.minutesElapsed += 0.01
                }else{
                    self.minutesElapsed = 0.0
                    self.mode = .work
                }
            }
        }
    }
    
    func stop() {
        timer.invalidate()
        mode = .stopped
        minutesElapsed = 0.0
    }
}
