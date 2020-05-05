//
//  ArticleDetailViewController.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 5/4/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var articleContentView: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var article:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.article?.title
        loadNewsImage(self.article!.imageUrl!)
        self.articleContentView.text = self.article?.author
    }
    
    
    @IBAction func moreButtonClick(_ sender: Any) {
        if let url = URL(string: self.article!.articleUrl!) {
            UIApplication.shared.open(url)
        }
    }
    
    func loadNewsImage(_ urlString: String) {
           // URL comes from API response; definitely needs some safety checks
           if let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
               if let url = URL(string: urlStr) {
                   let dataTask = URLSession.shared.dataTask(with: url,
                   completionHandler: {(data, response, error) -> Void in
                       if let imageData = data {
                        self.articleImageView.image = UIImage(data: imageData)
                       }
                   })
                   dataTask.resume()
               }
           }
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
