//
//  ViewController.swift
//  GestureApp
//
//  Created by Brandon Campbell on 3/9/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var BottomLabel: UILabel!
    @IBOutlet weak var BottomImage: UIImageView!
    @IBOutlet weak var ClearButton: UIButton!
    
    @IBAction func ClearButtonTapped(_ sender: UIButton) {
        for boxView in boxViews {
        boxView.removeFromSuperview()
        }
        boxViews.removeAll()
        // Hide the image
        // Hide the label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the gesture recognizers
        let smileGestureRecognizer = SmileGestureRecognizer(target: self, action: #selector(handleSmile))
        let frownGestureRecognizer = FrownGestureRecognizer(target: self, action: #selector(handleFrown))
        smileGestureRecognizer.delegate = self
        frownGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(smileGestureRecognizer)
        self.view.addGestureRecognizer(frownGestureRecognizer)
        
        // Make sure the label and images aren't visible
    }
    
    @objc func handleSmile(_ sender: SmileGestureRecognizer) {
        if sender.state == .ended {
            print("smile detected")
            // Show the proper image and label
        }
    }
    
    @objc func handleFrown(_ sender: FrownGestureRecognizer) {
        if sender.state == .ended {
            print("frown detected")
            // Show the proper image and label
        }
    }
}

