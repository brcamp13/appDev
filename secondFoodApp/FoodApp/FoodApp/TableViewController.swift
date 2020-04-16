//
//  TableViewController.swift
//  FoodApp
//
//  Created by Brandon Campbell on 2/17/20.
//  Copyright © 2020 Brandon Campbell. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {
    
    var foods = [(FoodModel, Int)]()
    var genericFoodName: String?
    
    var foodOptions = [("chicken", "chickenn.jpg"), ("sushii", "sushi.jpg"), ("pasta", "pastaa.jpg"), ("lettuce", "lettuce.jpg"), ("ice cream", "iceCream.jpg")]
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
        // Get the random food from list of 5 w/corresponding image name
        let foodIndex = Int.random(in: 0 ... 4)
        let foodName = foodOptions[foodIndex].0
        let imageFileName = foodOptions[foodIndex].1
        
        // Get the random calorie count
        let calorieCount = Int.random(in: 100 ... 500)
        
        // Insert into coredata
        addFood(name: foodName, imageFileName: imageFileName, calories: calorieCount)
        
        // Update foods array
        updateFoodArray()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        initialize()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Initialize an array of three food items, all different.
    }
    
    // Clear the food array and update the foods based on what's in coredata
    func updateFoodArray() {
        self.foods.removeAll()
        let updatedFoods = getFood() as! [FoodModel]
        var index = 0
        for food in updatedFoods {
            self.foods.append((food, index))
            index = index + 1
        }
    }
    
    func initialize() {
        // self.foods.append((pasta, foods.count))
        tableView.rowHeight = 58
        updateFoodArray()
        tableView.reloadData()
    }
    
    func removeFood(_ food: FoodModel) {
        managedObjectContext.delete(food)
        appDelegate.saveContext()
    }
    
    func addFood(name: String, imageFileName: String, calories: Int) {
        let food = NSEntityDescription.insertNewObject(forEntityName:
        "FoodModel", into: self.managedObjectContext)
        food.setValue(name, forKey: "name")
        food.setValue(imageFileName, forKey: "imageFileName")
        food.setValue(calories, forKey: "calories")
        appDelegate.saveContext() // In AppDelegate.swift
    }
    
    func getFood() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FoodModel")
        var food: [NSManagedObject] = []
        do {
            food = try self.managedObjectContext.fetch(fetchRequest)
        } catch {
            print("getFood error: \(error)")
        }
        return food
    }

    // MARK: - Table view data source
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.foods.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodCell
        let indexRow = indexPath.row
        cell.foodNameLabel.text = self.foods[indexRow].0.name
        cell.foodImageView.image = UIImage(named: self.foods[indexRow].0.imageFileName!)
        cell.calorieLabel.text = "\(self.foods[indexRow].0.calories) cals"
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
            // Delete the food from core data, call the func that updates array from core data
            // Delete the row from the data source first
            let row = indexPath.row
            let food = self.foods[row]
            self.foods.remove(at: row)
            self.removeFood(food.0)
            self.updateFoodArray()
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
