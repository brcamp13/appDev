//
//  NewsArticlesTableViewController.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 5/3/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

var articles = [Article]()

class NewsArticlesTableViewController: UITableViewController {
    

    var topicName:String! = nil
    var newsURLString:String! = nil
    var apiKey = "7378f52d4d104cc2bbd1c2c916ee3e1a"
    var image:UIImage! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsURLString = "http://newsapi.org/v2/everything?" +
            "q=" +
            self.topicName +
            "&" +
            "from=2020-04-30&" +
            "sortBy=popularity&" +
            "apiKey=" +
            self.apiKey
        
        print(self.newsURLString!)
        articles.removeAll()
        self.getArticles()

        // Do any additional setup after loading the view.
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
            let articleArray = jsonDict1["articles"] as? [Dictionary<String, Any>],
                articleArray.count > 0 else {
            print("error: invalid JSON data")
            return
        }
        
        // articleArray should have all of the news articles for the topic, so go through and add them as table cells somehow
        
        for item in articleArray {
            let article = Article(author: item["author"] as! String, title: item["title"] as! String, imageUrl: item["urlToImage"] as! String, articleUrl: item["url"] as! String)
            articles.append(article)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    // OKAY, SO PUT THIS IN THE ARTICLE DETAIL VIEW AND JUST SAVE THE IMAGE URL AND CALL THIS ONCE YOU LOAD THE DETAILED VIEW OF THE ARTICLE...... NOT ON LIST, JUST HAVE TITLES
    func loadNewsImage(_ urlString: String) {
        // URL comes from API response; definitely needs some safety checks
        if let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlStr) {
                let dataTask = URLSession.shared.dataTask(with: url,
                completionHandler: {(data, response, error) -> Void in
                    if let imageData = data {
                        self.image = UIImage(data: imageData)
                    }
                })
                dataTask.resume()
            }
        }
   }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return articles.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsArticleCell", for: indexPath) as! NewsArticleCell

            // Configure the cell...
            let article = articles[indexPath.row]
            loadNewsImage(article.imageUrl)
            cell.articleLabel?.text = article.title

            return cell
        }

        // Override to support conditional editing of the table view.
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        
//        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let cell = tableView.cellForRow(at: indexPath) as! NewsArticleCell
//
//            // Check if notifications are enabled
//    //        let center = UNUserNotificationCenter.current()
//    //        center.getNotificationSettings(completionHandler: { (settings) in
//    //            if settings.alertSetting == .enabled {
//    //                self.displaySchedulingAlert(cell: cell, indexPath: indexPath)
//    //            } else {
//    //                print("Nothing is supposed to happen here lol")
//    //                self.displaySchedulingAlert(cell: cell, indexPath: indexPath)
//    //            }
//    //        })
//
//            // Do the segue to the article detail page
////            self.selectedFoodName = cell.articleLabel.text!
////            performSegue(withIdentifier: "TopicTableToArticles", sender: nil)
//
//            // If yes, then generate an alert asking the user if they would like to schedule a notification
//            // Title: "Food Notification", message: Do you want to schedule a notification for <food item> with yes or no as choices
//            // If no, nothing happens. If yes, item becomes red, notification scheduled for 5 seconds from now
//        }
        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if (segue.identifier == "TopicTableToArticles") {
//                let articlesVC = segue.destination as! NewsArticlesTableViewController
//                articlesVC.topicName = selectedFoodName
//            }
//        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
