//
//  ViewController.swift
//  QuizApp
//
//  Created by Brandon Campbell on 1/16/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count: Int = 1
    var ordinalFoods:[Int:String] = [1: "Pasta!", 2: "Sushi!", 3: "Chicken!"]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    
    @IBAction func nextButtonTapped(_sender: Any) {
        count += 1
        if count > 3 {
            count = 1
        }
        
        imageView.image = UIImage(named: String(count) + ".jpg")
        topLabel.text = "My #" + String(count) + " favorite food is..."
        foodLabel.text = ordinalFoods[count]!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        count = 1
        topLabel.text = "My #1 favorite food is..."
        imageView.image = UIImage(named: "1.jpg")
        foodLabel.text = "Pasta!"
    }
    
    
    // Put an IBAction function header in here that detects when the button is pressed
    // IBAction function will get rid of current image, show next image in sequence
    // This can be accomplished by having a count variable and then naming each image 1, 2, 3, etc and just displaying image("count")
    // Shouldn't be too bad. A bit hacky, but not too bad
    // Also have to put my #1, #2 favorite food which can be accomplished by, again, using a count variable
    // When it hits the last food, set count back to 1
    // Have to change the label name of the food too, so perhaps create some sort of mapping data structure that maps food num to food title. That should work. 


}

