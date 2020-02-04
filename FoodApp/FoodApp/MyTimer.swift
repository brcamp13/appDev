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
}

class MyTimer {
    var delegate: MyTimerDelegate?
    var initialTime: Int = 60
    
    func setInitialTime(_ initTime: Int) {
        initialTime = initTime
    }
    
    func start() {
        // TODO
        // LEFT OFF AT 24:46 OF JAN 31 LECTURE VIDEO
    }
    
    func stop() {
        // TODO
    }
}
