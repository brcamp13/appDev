//
//  NewsArticleCell.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 4/29/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

class NewsArticleCell: UITableViewCell {

    @IBOutlet weak var articleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
