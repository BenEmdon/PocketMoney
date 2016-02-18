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
var indexSelected = 0


class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate {
    
    // MARK: Class variables
    
    var showiOU = Bool()
    
    // MARK: IBOutlets
    
    @IBOutlet weak var iOUSegmentedController: UISegmentedControl!
    
    @IBAction func iOUSegmentedControllerAction(sender: AnyObject) {
        if iOUSegmentedController.selectedSegmentIndex == 0 {
            showiOU = false
        }
        if iOUSegmentedController.selectedSegmentIndex == 1 {
            showiOU = true
        }
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonDidPress(sender: AnyObject) {
        indexSelected = -1
        performSegueWithIdentifier("DetailsSegue", sender: self)
    }
    
    
    
    // MARK: - View will/did functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // rowHeight overides all
        //tableView.rowHeight = 88
        fetchData()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "StoryViewBackground.pdf"))
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
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
        
        cell.backgroundColor = UIColor.clearColor()
        
        let value = values[indexPath.row]
        
        
        cell.amountLabel.text = value.valueForKey("amountString") as? String
        let dateObject = value.valueForKey("transactionDate") as! NSDate
        cell.timeLabel.text = timeAgoSinceDate(dateObject)
        cell.iOU = value.valueForKey("iou") as! Bool
        let positive = value.valueForKey("positive") as! Bool
        cell.descriptionLabel.text = value.valueForKey("descriptionString") as? String
        
        if positive {
            cell.colorViewDescription.backgroundColor = UIColor(red:0.309, green:0.831, blue:0.453, alpha:0.9)
            
        }
        if !positive {
            cell.colorViewDescription.backgroundColor = UIColor(red:1, green:0.38, blue:0.368, alpha:0.9)
        }
        
        if cell.iOU == !showiOU {
            cell.hidden = true
        }
        
        
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var rowHeight: CGFloat = 88.0
        let iOU = values[indexPath.row].valueForKey("iou") as! Bool
        if iOU == !showiOU {
            rowHeight = 0
            return rowHeight
        }
        else {
            return rowHeight
        }
    }
    
    
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        indexSelected = indexPath.row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("DetailsSegue", sender: self)
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action, indexPath) in
            self.tableView.dataSource?.tableView?(
                self.tableView,
                commitEditingStyle: .Delete,
                forRowAtIndexPath: indexPath
            )
            return
        })
        
        deleteButton.backgroundColor = UIColor(red:0.831, green:0.421, blue:0.421, alpha:1)
        
        return [deleteButton]
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
    
    // MARK: - Fetch Data from Core Data
    
    func fetchData() {
        // Get the managed object context
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        // Create a fetch request into Core Data
        let fetchRequest = NSFetchRequest(entityName: "Value")
        // Max batch size, for demo purposes
        // TODO: DataLeak
        //fetchRequest.fetchBatchSize = 100
        
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
    
    func timeAgoSinceDate(date:NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components: NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 1) {
            return "\(components.year)y"
        }
        else if (components.month >= 1) {
            return "\(components.month)m"
        }
        else if (components.weekOfYear >= 1) {
            return "\(components.weekOfYear)w"
        }
        else if (components.day >= 1) {
            return "\(components.day)d"
        }
        else if (components.hour >= 1) {
            return "\(components.hour)h"
        }
        else if (components.minute >= 1) {
            return "\(components.minute)min"
        }
        else if (components.second >= 3) {
            return "\(components.second)s"
        }
        else {
            return "now"
        }
    }
    
    
}
