//
//  MyTimer.swift
//  FoodApp
//
//  Created by Brandon Campbell on 2/4/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import Foundation

protocol MyTimerDelegate {
    func timeChanged (time: Int)
    func timesUp ()
}

class MyTimer {
    var delegate: MyTimerDelegate?
    var initialTime: Int = 5
    var currentTime: Int = 5
    var timer: Timer?
    
    func setInitialTime(_ initTime: Int) {
        initialTime = initTime
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: handleTick)
    }
    
    func handleTick (timer: Timer) {
        if currentTime > 0 {
            
            currentTime = currentTime - 1
            delegate?.timeChanged(time: currentTime)
            
            if currentTime == 0 {
                delegate?.timesUp()
            }
            
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    func reset() {
        if currentTime != initialTime {
            currentTime = initialTime
            delegate?.timeChanged(time: currentTime)
        }
    }
}
