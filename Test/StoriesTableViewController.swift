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
    
    // MARK: - IBActions
    
    @IBAction func menuButtonDidPress(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
        print(values)
    }
    
    
    // MARK: - View will/did functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // rowHeight overides all
        tableView.rowHeight = 88
        fetchData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DataCell", forIndexPath: indexPath) as! StoryTableViewCell
        let value = values[indexPath.row]
        
        cell.amountLabel.text = value.valueForKey("amountString") as? String
        let dateObject = value.valueForKey("transactionDate") as! NSDate
        cell.timeLabel.text = timeAgoSinceDate(dateObject, numericDates: true)
        let iouBool = value.valueForKey("iou") as! Bool
        let positive = value.valueForKey("positive") as! Bool
        cell.descriptionLabel.text = value.valueForKey("descriptionString") as? String
        
        if !iouBool {
            if positive {
                cell.colorViewDescription.backgroundColor = UIColor(red:0.329, green:0.881, blue:0.481, alpha:1)
            }
            if !positive {
                cell.colorViewDescription.backgroundColor = UIColor(red:0.875, green:0.365, blue:0.356, alpha:1)
            }
        }
        else {
            cell.colorViewDescription.backgroundColor = UIColor.darkGrayColor()
        }
        
        
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        indexToPass = indexPath.row
        performSegueWithIdentifier("InfoSegue", sender: self)
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
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "InfoSegue" {
            if let destinationVC = segue.destinationViewController as? DetailsViewController {
                destinationVC.indexPassedBySegue = indexToPass
            }
        }
    }
    
    
    // MARK: - Fetch Data from Core Data
    
    func fetchData() {
        // Get the managed object context
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        // Create a fetch request into Core Data
        let fetchRequest = NSFetchRequest(entityName: "Value")
        // Max batch size, for demo purposes
        fetchRequest.fetchBatchSize = 100
        
        // Sort by transaction date
        let sectionSortDescriptor = NSSortDescriptor(key: "transactionDate", ascending: false)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        // Execute fetch request
        do {
            values = try managedObjectContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        }
        catch {
            print("Fetch failed: \(error)")
        }
    }
    
    
    // MARK: Helper Methods
    
    
    func amountToString(value: Float) -> String {
        return "$" + String(format: "%.2f", value)
    }

    // TODO: Reduce timeAgoSinceDate
    
    func timeAgoSinceDate(date:NSDate, numericDates: Bool) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 2) {
            return "\(components.year)y"
        } else if (components.year >= 1){
            if (numericDates){
                return "1y"
            } else {
                return "Last year"
            }
        } else if (components.month >= 2) {
            return "\(components.month)m"
        } else if (components.month >= 1){
            if (numericDates){
                return "1m"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear)w"
        } else if (components.weekOfYear >= 1){
            if (numericDates){
                return "1w"
            } else {
                return "Last week"
            }
        } else if (components.day >= 2) {
            return "\(components.day)d"
        } else if (components.day >= 1){
            if (numericDates){
                return "1d"
            } else {
                return "Yesterday"
            }
        } else if (components.hour >= 2) {
            return "\(components.hour)h"
        } else if (components.hour >= 1){
            if (numericDates){
                return "1h"
            } else {
                return "An hour ago"
            }
        } else if (components.minute >= 2) {
            return "\(components.minute)min"
        } else if (components.minute >= 1){
            if (numericDates){
                return "1min"
            } else {
                return "A minute ago"
            }
        } else if (components.second >= 3) {
            return "\(components.second)s"
        } else {
            return "<1s"
        }
    }
    
    
}
