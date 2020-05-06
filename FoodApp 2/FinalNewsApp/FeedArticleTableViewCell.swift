//
//  FeedArticleTableViewCell.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 5/5/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

class FeedArticleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
