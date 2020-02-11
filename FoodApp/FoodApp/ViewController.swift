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
    
    @IBAction func unwindFromAddFoodView (sender: UIStoryboardSegue) {
        let addFoodVC = sender.source as! AddFoodViewController
        // if let secondViewText = secondVC.secondViewText {
        // print("Second View Text: \(secondViewText)")
        // }
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addFromView1") {
            let addFoodVC = segue.destination as! AddFoodViewController
            // secondVC.messageFromFirstView = messageTextField.text
        }
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
}
