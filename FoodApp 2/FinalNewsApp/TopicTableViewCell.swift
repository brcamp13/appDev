//
//  TopicTableViewCell.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 5/4/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var cellText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
