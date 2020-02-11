//
//  AddFoodViewController.swift
//  FoodApp
//
//  Created by Brandon Campbell on 2/11/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController {

    var messageFromFirstView: String?
    var addFoodViewData: String?
    var buttonTapped: String?
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        print("cancel tapped")
        buttonTapped = "cancel"
        performSegue(withIdentifier: "View2ToView1", sender: self)
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        print("save tapped")
        addFoodViewData = textField.text
        buttonTapped = "save"
        performSegue(withIdentifier: "View2ToView1", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = messageFromFirstView
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
