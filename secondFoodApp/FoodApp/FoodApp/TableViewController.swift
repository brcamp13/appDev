//
//  TableViewController.swift
//  FoodApp
//
//  Created by Brandon Campbell on 2/17/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var foods = [FoodItem]()
    var sortedFoods = [FoodItem]()
    var genericFoodName: String?
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        // Add generic food item to the foods array.
        let genericFood = FoodItem(name: genericFoodName!, imageName: "genericFood.jpg", calories: 690)
        self.foods.append(genericFood)
        processItems()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        processItems()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Initialize an array of three food items, all different.
    }
    
    func initialize() {
        // Add the starting food items to the food array.
        let pasta = FoodItem(name: "Pasta", imageName: "pasta.jpg", calories: 500)
        let sushi = FoodItem(name: "Sushi", imageName: "sushi.jpg", calories: 150)
        let chicken = FoodItem(name: "Chicken", imageName: "chicken.jpg", calories: 250)
        self.foods.append(pasta)
        self.foods.append(sushi)
        self.foods.append(chicken)
        
        tableView.rowHeight = 58
    }

    // MARK: - Table view data source
    
    func processItems() {
        if UserDefaults.standard.bool(forKey: "sortItems") {
            sortedFoods = foods.sorted(by: {$0.name < $1.name})
        } else{
            sortedFoods = foods
        }
        
        genericFoodName = UserDefaults.standard.object(forKey: "genericFood") as? String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        processItems()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sortedFoods.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodCell
        let indexRow = indexPath.row
        cell.foodNameLabel.text = self.sortedFoods[indexRow].name
        cell.foodImageView.image = UIImage(named: self.sortedFoods[indexRow].imageName)
        cell.calorieLabel.text = "\(self.sortedFoods[indexRow].calories) cals"
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
            // Delete the row from the data source first
            let row = indexPath.row
            self.foods.remove(at: row)
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
