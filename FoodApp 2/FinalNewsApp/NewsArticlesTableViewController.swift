//
//  NewsArticlesTableViewController.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 5/3/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//
//
// Tableview controller for the single topic articles list (when you click a topic from the main page).

import UIKit

var articles = [Article]()

class NewsArticlesTableViewController: UITableViewController {
    

    var topicName:String! = nil
    var newsURLString:String! = nil
    var apiKey = "7378f52d4d104cc2bbd1c2c916ee3e1a"
    var selectedArticle:Article! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepate the API url.
        self.newsURLString = "http://newsapi.org/v2/everything?" +
            "q=" +
            self.topicName +
            "&" +
            "from=2020-04-30&" +
            "sortBy=popularity&" +
            "apiKey=" +
            self.apiKey
        
        // Get all articles, making sure to clear current articles beforehand.
        articles.removeAll()
        self.getArticles()
    }
    
    // Make the API call.
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
    
    // Handle the API response.
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
        
       // Add all returned articles to the global article array which will be displayed in a table on this page.
        for item in articleArray {
            let article = Article(author: item["author"] as? String ?? "Null author", title: item["title"] as? String ?? "Null title", imageUrl: item["urlToImage"] as? String ?? "https://lh3.googleusercontent.com/proxy/ta8LgzcUCtO9utHsGF05HOIDAIyeAlAT4AGXDRVJnZpIvidqT4fYDpyVrvwCQpe35kp7uNbBLd53uDFzvKmQtHsUXXA4_iNXJC4W2rIs5-TO_R5NlTEK5w", articleUrl: item["url"] as? String ?? "https://www.google.com/", publishedAt: item["publishedAt"] as? Date ?? Date())
            articles.append(article)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsArticleCell", for: indexPath) as! NewsArticleCell

        // Configure the cell...
        let article = articles[indexPath.row]
        cell.articleLabel?.text = article.title

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Do the segue to the article detail page
        self.selectedArticle = articles[indexPath.row]
        performSegue(withIdentifier: "ShowArticleDetails", sender: nil)
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowArticleDetails") {
            let articlesVC = segue.destination as! ArticleDetailViewController
            articlesVC.article = self.selectedArticle
        }
    }
}
