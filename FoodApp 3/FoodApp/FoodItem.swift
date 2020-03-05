//
//  FoodItem.swift
//  FoodApp
//
//  Created by Larry Holder on 2/12/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import Foundation

class FoodItem {
    var name: String
    var imageFileName: String
    var caloriesPerServing: Int
    
    init(name: String, imageFileName: String, caloriesPerServing: Int) {
        self.name = name
        self.imageFileName = imageFileName
        self.caloriesPerServing = caloriesPerServing
    }
}
