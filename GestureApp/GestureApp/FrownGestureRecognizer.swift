//
//  FrownGestureRecognizer.swift
//  GestureApp
//
//  Created by Brandon Campbell on 3/9/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

enum FrownPhases {
    case notStarted
    case initialPoint
    case downStroke
    case upStroke
}
class FrownGestureRecognizer : UIGestureRecognizer {
    var strokePhase : FrownPhases = .notStarted
    var initialTouchPoint : CGPoint = CGPoint.zero
    var trackedTouch : UITouch? = nil
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
       super.touchesBegan(touches, with: event)
       if touches.count != 1 {
          self.state = .failed
       }
     
       // Capture the first touch and store some information about it.
       if self.trackedTouch == nil {
          self.trackedTouch = touches.first
          self.strokePhase = .initialPoint
          self.initialTouchPoint = (self.trackedTouch?.location(in: self.view))!
       } else {
          // Ignore all but the first touch.
          for touch in touches {
             if touch != self.trackedTouch {
                self.ignore(touch, for: event)
             }
          }
       }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
       super.touchesMoved(touches, with: event)
       let newTouch = touches.first
       // There should be only the first touch.
       guard newTouch == self.trackedTouch else {
          self.state = .failed
          return
       }
       let newPoint = (newTouch?.location(in: self.view))!
       let previousPoint = (newTouch?.previousLocation(in: self.view))!
       if self.strokePhase == .initialPoint {
          // Make sure the initial movement is up and to the right.
          if newPoint.x >= initialTouchPoint.x && newPoint.y >= initialTouchPoint.y {
             print("upstroke")
             self.strokePhase = .upStroke
          } else {         self.state = .failed
          }
       } else if self.strokePhase == .upStroke {
          // Always keep moving left to right.
          if newPoint.x >= previousPoint.x {
             // If the y direction changes, the gesture is down.
             // Otherwise, the down stroke continues.
             if newPoint.y > previousPoint.y {
                print("downstroke")
                self.strokePhase = .downStroke
             }
          } else {
            // If the new x value is to the left, the gesture fails.
            self.state = .failed
          }
       } else if self.strokePhase == .downStroke {
          // If the new x value is to the left, or the new y value
          // changed directions again, the gesture fails.]
          if newPoint.x < previousPoint.x || newPoint.y < previousPoint.y {
             print("failed")
             self.state = .failed
          }
       }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
       super.touchesEnded(touches, with: event)
       let newTouch = touches.first
       let newPoint = (newTouch?.location(in: self.view))!
       // There should be only the first touch.
       guard newTouch == self.trackedTouch else {
          self.state = .failed
          return
       }
       // If the stroke was moving up and the final point is
       // above the initial point, the gesture succeeds.
       if self.state == .possible &&
             self.strokePhase == .downStroke &&
             newPoint.y >= initialTouchPoint.y {
          self.state = .recognized
       } else {
          self.state = .failed
       }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
       super.touchesCancelled(touches, with: event)
       self.initialTouchPoint = CGPoint.zero
       self.strokePhase = .notStarted
       self.trackedTouch = nil
       self.state = .cancelled
    }
     
    override func reset() {
       super.reset()
       self.initialTouchPoint = CGPoint.zero
       self.strokePhase = .notStarted
       self.trackedTouch = nil
    }
}
