//
//  MainTableViewController.swift
//  FoodApp
//
//  Created by Larry Holder on 2/12/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

var topicItems = [TopicItem]()

class MainTableViewController: UITableViewController {
    
    var newTopicText:String = ""
    var selectedTopicName:String! = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newTopicText != "" {
            let topicItem = TopicItem(name: newTopicText)
            topicItems.append(topicItem)
            newTopicText = ""
            tableView.reloadData()
        }
        else if newTopicText == "NONE" {
            print("Do nothing lol")
        }
        else {
            initializeFoodItems()
        }
        
        navigationItem.hidesBackButton = true
        tableView.rowHeight = 58
    }
    
    func initializeFoodItems() {
        // Do something with core data here
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topicItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicTableViewCell", for: indexPath) as! TopicTableViewCell

        // Configure the cell...
        let topicItem = topicItems[indexPath.row]
        cell.cellText?.text = topicItem.name

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            topicItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopicTableViewCell
        self.selectedTopicName = cell.cellText.text!
        performSegue(withIdentifier: "TopicTableToArticles", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "TopicTableToArticles") {
            let articlesVC = segue.destination as! NewsArticlesTableViewController
            articlesVC.topicName = selectedTopicName
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
