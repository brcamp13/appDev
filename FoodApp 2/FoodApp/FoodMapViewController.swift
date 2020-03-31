//
//  FoodMapViewController.swift
//  FoodApp
//
//  Created by Brandon Campbell on 3/24/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class FoodMapViewController: UIViewController {
    
    var labelName:String! = nil
    
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
