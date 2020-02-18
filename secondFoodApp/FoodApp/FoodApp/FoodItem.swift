//
//  FoodItem.swift
//  FoodApp
//
//  Created by Brandon Campbell on 2/17/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import Foundation

class FoodItem {
    var name: String
    var imageName: String
    var calories: Int
    
    init(name: String, imageName: String, calories: Int) {
        self.name = name
        self.imageName = imageName
        self.calories = calories
    }
}
