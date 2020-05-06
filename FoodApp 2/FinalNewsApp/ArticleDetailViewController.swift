//
//  ArticleDetailViewController.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 5/4/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//
// View controller for article detail view (with image, more button, author, etc.)

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var articleContentView: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var article:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view properties to their respective fields, make the async image call.
        self.titleLabel.text = self.article?.title
        loadNewsImage(self.article!.imageUrl!)
        self.articleContentView.text = self.article?.author
    }
    
    // After pressing the "more" button, opens the url of the news article in Safari.
    @IBAction func moreButtonClick(_ sender: Any) {
        if let url = URL(string: self.article!.articleUrl!) {
            UIApplication.shared.open(url)
        }
    }
    
    // Load the image for the news article (if it exists).
    func loadNewsImage(_ urlString: String) {
           // URL comes from API response; definitely needs some safety checks
           if let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
               if let url = URL(string: urlStr) {
                   let dataTask = URLSession.shared.dataTask(with: url,
                   completionHandler: {(data, response, error) -> Void in
                       if let imageData = data {
                        DispatchQueue.main.async {
                            self.articleImageView.image = UIImage(data: imageData)
                        }
                       }
                   })
                   dataTask.resume()
               }
           }
      }
}
