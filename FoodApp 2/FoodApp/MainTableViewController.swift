//
//  MainTableViewController.swift
//  FoodApp
//
//  Created by Larry Holder on 2/12/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

var foodItems = [FoodItem]()

class MainTableViewController: UITableViewController {
    
    var newFoodText:String = ""

//    @IBAction func addFoodItemTapped(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "secretPassage", sender: nil)
//        let foodItem = FoodItem(name: "Food", imageFileName: "food.png", caloriesPerServing: 100, notificationScheduled: false)
//        foodItems.append(foodItem)
//        tableView.reloadData()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newFoodText != "" {
            let foodItem = FoodItem(name: newFoodText, imageFileName: "food.png", caloriesPerServing: 100, notificationScheduled: false)
            foodItems.append(foodItem)
            newFoodText = ""
            print(foodItems)
            tableView.reloadData()
        }
        else if newFoodText == "NONE" {
            print("Do nothing lol")
        }
        else {
            initializeFoodItems()
        }
        
        navigationItem.hidesBackButton = true
        tableView.rowHeight = 58

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func initializeFoodItems() {
        var foodItem = FoodItem(name: "Pizza", imageFileName: "pizza.png", caloriesPerServing: 300, notificationScheduled: false)
        foodItems.append(foodItem)
        foodItem = FoodItem(name: "Spaghetti", imageFileName: "spaghetti.png", caloriesPerServing: 200, notificationScheduled: false)
        foodItems.append(foodItem)
        foodItem = FoodItem(name: "Ice Cream", imageFileName: "icecream.png", caloriesPerServing: 500, notificationScheduled: false)
        foodItems.append(foodItem)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodCell

        // Configure the cell...
        let foodItem = foodItems[indexPath.row]
        cell.foodImageView?.image = UIImage(named: foodItem.imageFileName)
        cell.foodNameLabel?.text = foodItem.name
        cell.caloriesLabel?.text = "\(foodItem.caloriesPerServing) cals"

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
            foodItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoodCell
        
        // Check if notifications are enabled
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler: { (settings) in
            if settings.alertSetting == .enabled {
                self.displaySchedulingAlert(cell: cell, indexPath: indexPath)
            } else {
                print("Nothing is supposed to happen here lol")
                self.displaySchedulingAlert(cell: cell, indexPath: indexPath)
            }
        })
        
        // If yes, then generate an alert asking the user if they would like to schedule a notification
        // Title: "Food Notification", message: Do you want to schedule a notification for <food item> with yes or no as choices
        // If no, nothing happens. If yes, item becomes red, notification scheduled for 5 seconds from now
    }
    
    func displaySchedulingAlert(cell: FoodCell, indexPath: IndexPath) {
        DispatchQueue.main.async {
            let notificationAlert = UIAlertController(title: "Food Notification", message: "Do you want to schedule a notification for the food " + cell.foodNameLabel.text!, preferredStyle: .alert)
            
            notificationAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                cell.foodNameLabel.textColor = UIColor.red
                self.scheduleNotification(cell: cell, indexPath: indexPath)
            }))
            
            notificationAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                print("Do nothing lol")
            }))
            
            self.present(notificationAlert, animated: true, completion: nil)
        }
    }
    
    func scheduleNotification(cell: FoodCell, indexPath: IndexPath) {
        let content = UNMutableNotificationContent()
        content.title = "Food Notification"
        content.body = "Time to eat the food"
        content.userInfo["foodID"] = foodItems[indexPath.row].id
        // Configure trigger for 5 seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0,
        repeats: false)
        // Create request
        let request = UNNotificationRequest(identifier: "NowPlusFive",
        content: content, trigger: trigger)
        // Schedule request
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: { (error) in
            if let err = error {
                print(err.localizedDescription)
            }
        })
    }
    
    func handleNotification(response: UNNotificationResponse) {
        let foodId = response.notification.request.content.userInfo["userId"] as! String
        
        let index = foodItems.firstIndex(where: { (item) -> Bool in
            item.id == foodId
        })
        
        // Access the cell and change its text color to black. 
        let indexPath = IndexPath(row: index!, section: 1)
        let cell = tableView.cellForRow(at: indexPath) as! FoodCell
        cell.foodNameLabel.textColor = UIColor.black
        
        
        print("received notification foodId: \(foodId)")
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
