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
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonTapped(_sender: Any) {
        count += 1
        if count > ordinalFoods.count {
            count = 1
        }
        
        if count > 3 {
            imageView.image = UIImage(named: "genericFood.jpg")
            topLabel.text = "My #" + String(count) + " favorite food is..."
            foodLabel.text = ordinalFoods[count]!
        } else {
            imageView.image = UIImage(named: String(count) + ".jpg")
            topLabel.text = "My #" + String(count) + " favorite food is..."
            foodLabel.text = ordinalFoods[count]!
        }
    }
    
    @IBAction func unwindFromAddFoodView (sender: UIStoryboardSegue) {
        let addFoodVC = sender.source as! AddFoodViewController
        let fromAddFoodViewData = addFoodVC.addFoodViewData
        let buttonTapped = addFoodVC.buttonTapped
        print("second view data = \(fromAddFoodViewData)")
        print("button tapped = \(buttonTapped)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addFromView1") {
            let addFoodVC = segue.destination as! AddFoodViewController
            addFoodVC.messageFromFirstView = "Enter name of food #" + String(ordinalFoods.count + 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = 1
        topLabel.text = "My #1 favorite food is..."
        imageView.image = UIImage(named: "1.jpg")
        foodLabel.text = "Pasta!"
    }
}
