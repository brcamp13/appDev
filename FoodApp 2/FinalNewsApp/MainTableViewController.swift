//
//  MainTableViewController.swift
//  FoodApp
//
//  Created by Larry Holder on 2/12/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit
import CoreData


var topicItems = [(NewsTopicModel, Int)]()

class MainTableViewController: UITableViewController {
    
    var newTopicText:String = ""
    var selectedTopicName:String! = nil
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        if newTopicText != "" {
            // Insert into coredata
            addTopic(name: newTopicText)
            
            // Update topic array
            updateTopicArray()
            
            // Clear new topic text
            newTopicText = ""
            tableView.reloadData()
        }
        else {
            initialize()
        }
    }
    
    // Clear the food array and update the foods based on what's in coredata
       func updateTopicArray() {
           topicItems.removeAll()
           let updatedTopics = getTopic() as! [NewsTopicModel]
           var index = 0
           for topic in updatedTopics {
               topicItems.append((topic, index))
               index = index + 1
           }
       }
       
       func initialize() {
           // self.foods.append((pasta, foods.count))
           navigationItem.hidesBackButton = true
           tableView.rowHeight = 58
           updateTopicArray()
           tableView.reloadData()
       }
    
    func removeTopic(_ topic: NewsTopicModel) {
        managedObjectContext.delete(topic)
        appDelegate.saveContext()
    }

    func addTopic(name: String) {
        let topic = NSEntityDescription.insertNewObject(forEntityName: "NewsTopicModel", into: self.managedObjectContext)
        topic.setValue(name, forKey: "name")
        appDelegate.saveContext() // In AppDelegate.swift
    }

    func getTopic() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewsTopicModel")
        var topic: [NSManagedObject] = []
        do {
            topic = try self.managedObjectContext.fetch(fetchRequest)
        } catch {
            print("getTopic error: \(error)")
        }
        return topic
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
        let indexRow = indexPath.row

        // Configure the cell...
        cell.cellText.text = topicItems[indexRow].0.name

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
            let row = indexPath.row
            // Delete the row from the data source
            let topic = topicItems[row]
            topicItems.remove(at: row)
            self.removeTopic(topic.0)
            self.updateTopicArray()
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
