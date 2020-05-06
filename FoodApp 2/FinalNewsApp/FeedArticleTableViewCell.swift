//
//  FeedArticleTableViewCell.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 5/5/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

class FeedArticleTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
