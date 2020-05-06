//
//  NewsFeedTableViewController.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 5/5/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

var feedArticles = [(Article, String)]()

class NewsFeedTableViewController: UITableViewController {
    
    var topicName:String! = nil
    var newsURLString:String! = nil
    var apiKey:String = "7378f52d4d104cc2bbd1c2c916ee3e1a"
    var selectedArticle:(Article, String)! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove all articles from the current feed, retrieve new articles.
        feedArticles.removeAll()
        self.tableView.rowHeight = 100
        self.getAllTopicArticles()
    }
    
    
    // Gets most popular articles from all user topics in a single request.
    func getAllTopicArticles() {
        
        // Do a single API call rather than a bunch. More efficient, don't have to deal with multi-async stuff
        var topics = [String]()
        for topic in topicItems {
            topics.append(topic.0.name!)
        }
        let joinedTopics = topics.joined(separator: " OR ")
        
        self.newsURLString = "http://newsapi.org/v2/everything?" + "q=" + joinedTopics + "&" + "from=2020-04-30&" + "sortBy=popularity&" + "apiKey=" + self.apiKey
            self.getArticles()
    }
    
    // Performs the API call provided the news url string created in getAllTopicArticles()
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
    
    // API call response handler.
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
        
        // Get all returned articles into an array. Feed articles still a tuple from previous implementation.
        for item in articleArray {
            let article = Article(author: item["author"] as? String ?? "Null author", title: item["title"] as? String ?? "Null title", imageUrl: item["urlToImage"] as? String ?? "https://lh3.googleusercontent.com/proxy/ta8LgzcUCtO9utHsGF05HOIDAIyeAlAT4AGXDRVJnZpIvidqT4fYDpyVrvwCQpe35kp7uNbBLd53uDFzvKmQtHsUXXA4_iNXJC4W2rIs5-TO_R5NlTEK5w", articleUrl: item["url"] as? String ?? "https://www.google.com/", publishedAt: item["publishedAt"] as? Date ?? Date())
            feedArticles.append((article, "Feed"))
        }
        
        DispatchQueue.main.async {
            // Trim the feed article array to the length specified in the settings bundle.
            let articleCount = UserDefaults.standard.string(forKey: "articleCount")
            feedArticles = Array(feedArticles.prefix(Int(articleCount!)!))
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feedArticles.count
   }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "feedArticleTableViewCell", for: indexPath) as! FeedArticleTableViewCell

       // Configure the cell...
       let article = feedArticles[indexPath.row]
       cell.articleTitleLabel?.text = article.0.title
    
       return cell
   }

   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       // Return false if you do not want the specified item to be editable.
       return true
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // Do the segue to the article detail page
       self.selectedArticle = feedArticles[indexPath.row]
       performSegue(withIdentifier: "ShowArticleDetailsFromFeed", sender: nil)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "ShowArticleDetailsFromFeed") {
           let articlesVC = segue.destination as! ArticleDetailViewController
        articlesVC.article = self.selectedArticle.0
       }
   }
}
