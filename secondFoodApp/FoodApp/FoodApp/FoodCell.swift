//
//  FoodCell.swift
//  FoodApp
//
//  Created by Brandon Campbell on 2/18/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import Foundation
import UIKit

class FoodCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code.
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state.
    }
}
