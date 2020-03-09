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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let smileGestureRecognizer = SmileGestureRecognizer(target: self, action: #selector(handleSmile))
        let frownGestureRecognizer = FrownGestureRecognizer(target: self, action: #selector(handleFrown))
        smileGestureRecognizer.delegate = self
        frownGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(smileGestureRecognizer)
        self.view.addGestureRecognizer(frownGestureRecognizer)
    }
    
    @objc func handleSmile(_ sender: SmileGestureRecognizer) {
        if sender.state == .ended {
            print("smile detected")
        }
    }
    
    @objc func handleFrown(_ sender: FrownGestureRecognizer) {
        if sender.state == .ended {
            print("frown detected")
        }
    }
}

