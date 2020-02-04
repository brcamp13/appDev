//
//  ViewController.swift
//  QuizApp
//
//  Created by Brandon Campbell on 1/16/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyTimerDelegate {
    var count: Int = 1
    var ordinalFoods:[Int:String] = [1: "Pasta!", 2: "Sushi!", 3: "Chicken!"]
    var initialTime = 5
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var initialTimeLabel: UILabel!
    @IBOutlet weak var initialTimeSlider: UISlider!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func nextButtonTapped(_sender: Any) {
        count += 1
        if count > 3 {
            count = 1
        }
        
        imageView.image = UIImage(named: String(count) + ".jpg")
        topLabel.text = "My #" + String(count) + " favorite food is..."
        foodLabel.text = ordinalFoods[count]!
    }
    
    @IBAction func initialTimeSliderValueChanged(_ sender: UISlider) {
        let initTime = Int(sender.value)
        initialTimeLabel.text = "Delay: \(initTime)s"
        myTimer?.setInitialTime(initTime)
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        myTimer?.start()
    }
    
    @IBAction func stopTapped(_ sender: UIButton) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        myTimer?.stop()
    }
    
    func timeChanged(time: Int) {
        print("Time changed")
    }
    
    func timesUp() {
        count += 1
        if count > 3 {
            count = 1
        }
        
        imageView.image = UIImage(named: String(count) + ".jpg")
        topLabel.text = "My #" + String(count) + " favorite food is..."
        foodLabel.text = ordinalFoods[count]!
        
        myTimer?.reset()
    }
    
    var myTimer: MyTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = 1
        topLabel.text = "My #1 favorite food is..."
        imageView.image = UIImage(named: "1.jpg")
        foodLabel.text = "Pasta!"
        myTimer = MyTimer()
        myTimer?.delegate = self
        myTimer?.setInitialTime(initialTime)
        initialTimeLabel.text = "Delay: \(initialTime)s"
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    
    // Put an IBAction function header in here that detects when the button is pressed
    // IBAction function will get rid of current image, show next image in sequence
    // This can be accomplished by having a count variable and then naming each image 1, 2, 3, etc and just displaying image("count")
    // Shouldn't be too bad. A bit hacky, but not too bad
    // Also have to put my #1, #2 favorite food which can be accomplished by, again, using a count variable
    // When it hits the last food, set count back to 1
    // Have to change the label name of the food too, so perhaps create some sort of mapping data structure that maps food num to food title. That should work. 


}

