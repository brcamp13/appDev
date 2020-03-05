//
//  MainTableViewController.swift
//  FoodApp
//
//  Created by Larry Holder on 2/12/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var foodItems = [FoodItem]()

    @IBAction func addFoodItemTapped(_ sender: UIBarButtonItem) {
        let foodItem = FoodItem(name: "Food", imageFileName: "food.png", caloriesPerServing: 100)
        foodItems.append(foodItem)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.rowHeight = 58
        initializeFoodItems()
    }
    
    func initializeFoodItems() {
        var foodItem = FoodItem(name: "Pizza", imageFileName: "pizza.png", caloriesPerServing: 300)
        foodItems.append(foodItem)
        foodItem = FoodItem(name: "Spaghetti", imageFileName: "spaghetti.png", caloriesPerServing: 200)
        foodItems.append(foodItem)
        foodItem = FoodItem(name: "Ice Cream", imageFileName: "icecream.png", caloriesPerServing: 500)
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
