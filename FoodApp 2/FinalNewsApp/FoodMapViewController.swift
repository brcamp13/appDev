//
//  FoodMapViewController.swift
//  FoodApp
//
//  Created by Brandon Campbell on 3/24/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

class FoodMapViewController: UIViewController {
    
    var labelName:String! = nil
    var newsURLString:String! = nil
    var apiKey = "7378f52d4d104cc2bbd1c2c916ee3e1a"
    
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsURLString = "http://newsapi.org/v2/everything?" +
            "q=" +
            self.labelName +
            "&" +
            "from=2020-04-30&" +
            "sortBy=popularity&" +
            "apiKey=" +
            self.apiKey;
        print(self.newsURLString!)
        mapLabel.numberOfLines = 0
        mapLabel.lineBreakMode = .byWordWrapping
        mapLabel.sizeToFit()
        mapLabel.text = "No recipes found"
        self.getArticles()
    }
    
    func getArticles() {
        // May not know exactly what's in the URL, so replace special characters with % encoding
        if let urlStr = newsURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        if let url = URL(string: urlStr) {
            let dataTask = URLSession.shared.dataTask(with: url,
            completionHandler: handleNewsResponse)
            dataTask.resume()
        }
    }
    }
    
    func handleNewsResponse (data: Data?, response: URLResponse?, error: Error?) {
        
        // 1. Check for error in request (e.g., no network connection)
        if let err = error {
            print("error: \(err.localizedDescription)")
            return
        }
        
        // 2. Check for improperly-formatted response
        guard let httpResponse = response as? HTTPURLResponse else {
            print("error: improperly-formatted response")
            return
        }
        let statusCode = httpResponse.statusCode
        
        // 3. Check for HTTP error
        guard statusCode == 200 else {
            let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            print("HTTP \(statusCode) error: \(msg)")
            return
        }
        
        // 4. Check for no data
        guard let somedata = data else {
            print("error: no data")
            return
        }
        
        
        // 5. Check for properly-formatted JSON data
        guard let jsonObj = try? JSONSerialization.jsonObject(with: somedata),
                let jsonDict1 = jsonObj as? [String: Any],
                let articleArray = jsonDict1["articles"] as? [Any],
                articleArray.count > 0,
                let jsonDict2 = articleArray[0] as? [String: Any],
                let titleStr = jsonDict2["title"] as? String,
                let urlToImage = jsonDict2["urlToImage"] as? String else {
            print("error: invalid JSON data")
            return
        }
        
        // 6. Everything seems okay
        let imageUrl = urlToImage
        self.loadNewsImage(imageUrl)
        DispatchQueue.main.async {
            self.mapLabel.text = titleStr
        }
    }
    
    func loadNewsImage(_ urlString: String) {
        
        // URL comes from API response; definitely needs some safety checks
        if let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlStr) {
                let dataTask = URLSession.shared.dataTask(with: url,
                completionHandler: {(data, response, error) -> Void in
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.foodImage.image = image
                        }
                    }
                })
                dataTask.resume()
            }
        }
    }
}
