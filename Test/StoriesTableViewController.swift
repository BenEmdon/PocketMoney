//
//  StoriesTableViewController.swift
//  Test
//
//  Created by Benjamin Emdon on 2015-12-27.
//  Copyright © 2015 Ben Emdon. 
//

import UIKit
import CoreData

var values = [NSManagedObject]()

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate {
    
    var indexToPass = 0
    
    // MARK: Overriden functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44
        fetchData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // TODO: values.sortInPlace({ $0.timeCreated.compare($1.timeCreated) == NSComparisonResult.OrderedDescending })
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        indexToPass = indexPath.row
        performSegueWithIdentifier("InfoSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
        // TODO: values.sortInPlace({ $0.timeCreated.compare($1.timeCreated) == NSComparisonResult.OrderedDescending })
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DataCell", forIndexPath: indexPath) as! StoryTableViewCell
        let value = values[indexPath.row]
        
        let positive = value.valueForKey("positive") as! Bool
        
        // TODO: let timeCreated: NSDate
        
        cell.amountLabel.text = value.valueForKey("amountString") as? String
        if positive {
            cell.badgeImage.image = UIImage(named: "Plus")
        }
        if !positive {
            cell.badgeImage.image = UIImage(named: "Minus")
        }
        
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // Handles delete (by removing the data from array and updating the tableview)
            // removes the deleted item from the model
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(values[indexPath.row] as NSManagedObject)
            values.removeAtIndex(indexPath.row)
            
            do {
                try context.save()
            }
            catch {
                print("Delete failed \(error)")
            }
            
            // tableView.reloadData()
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "InfoSegue" {
            if let destinationVC = segue.destinationViewController as? DetailsViewController {
                destinationVC.numberToDisplay = indexToPass
            }
        }
    }
    
    
    
    
    @IBAction func menuButtonDidPress(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
        print(values)
    }
    
    
    func amountToString(value: Float) -> String {
        return "$" + String(format: "%.2f", value)
    }
    

    
    func fetchData() {
        // Get the managed object context
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        // Create a fetch request into Core Data
        let fetchRequest = NSFetchRequest(entityName: "Value")
        
        // Execute fetch request
        do {
            values = try managedObjectContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        }
        catch {
            print("Fetch failed: \(error)")
        }
        
        //let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest)
        
        
    }
    
}
