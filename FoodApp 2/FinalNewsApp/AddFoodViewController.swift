//
//  AddFoodViewController.swift
//  FoodApp
//
//  Created by Brandon Campbell on 3/23/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController {

    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var AddFoodTextField: UITextField!
    
    @IBAction func SaveButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SaveSegue", sender: nil)
    }
    
    @IBAction func CancelButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CancelSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SaveSegue") {
            let secondVC = segue.destination as! MainTableViewController
            secondVC.newTopicText = AddFoodTextField.text!
        }
        else if (segue.identifier == "CancelSegue") {
            let secondVC = segue.destination as! MainTableViewController
            secondVC.newTopicText = "NONE"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        AddFoodTextField.text = ""
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
