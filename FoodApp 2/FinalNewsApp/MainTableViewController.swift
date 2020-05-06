//
//  MainTableViewController.swift
//  FoodApp
//
//  Created by Brandon Campbell on 5/6/20.
//

import UIKit
import CoreData


var topicItems = [(NewsTopicModel, Int)]()

class MainTableViewController: UITableViewController {
    
    var newTopicText:String = ""
    var selectedTopicName:String! = nil
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!

    @IBOutlet weak var feedBarButton: UIBarButtonItem!
    
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
    
    // News feed button click handler. Poorly named.
    @IBAction func barButtonClick(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showNewsFeed", sender: nil)
    }
    
    // Clear the topic array and update the topics based on what's in coredata
       func updateTopicArray() {
           topicItems.removeAll()
           let updatedTopics = getTopic() as! [NewsTopicModel]
           var index = 0
           for topic in updatedTopics {
               topicItems.append((topic, index))
               index = index + 1
           }
       }
       
    // Initialize the topic table view.
       func initialize() {
           navigationItem.hidesBackButton = true
           tableView.rowHeight = 58
           updateTopicArray()
           tableView.reloadData()
       }
    
    // Remove a topic from core data.
    func removeTopic(_ topic: NewsTopicModel) {
        managedObjectContext.delete(topic)
        appDelegate.saveContext()
    }

    // Add a topic to core data.
    func addTopic(name: String) {
        let topic = NSEntityDescription.insertNewObject(forEntityName: "NewsTopicModel", into: self.managedObjectContext)
        topic.setValue(name, forKey: "name")
        appDelegate.saveContext() // In AppDelegate.swift
    }

    // Get a topic from core data
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
}
