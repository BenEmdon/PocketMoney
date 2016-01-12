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
    
    // MARK: Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: remove refreshControl
        //refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
    
        fetchData()
        
        tableView.estimatedRowHeight = 44
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // TODO: values.sortInPlace({ $0.timeCreated.compare($1.timeCreated) == NSComparisonResult.OrderedDescending })
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("InfoSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        // TODO: values.sortInPlace({ $0.timeCreated.compare($1.timeCreated) == NSComparisonResult.OrderedDescending })
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    
    @IBAction func menuButtonDidPress(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
        print(values)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func amountToString(value: Float) -> String {
        return "$" + String(format: "%.2f", value)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DataCell", forIndexPath: indexPath) as! StoryTableViewCell
        
        let value = values[indexPath.row]
        
        let positive = value.valueForKey("positive") as! Bool
        
        // TODO: let timeCreated: NSDate
        
        cell.amountLabel.text = value.valueForKey("amountString") as? String
        
        if positive {
            cell.badgeImage.image = UIImage(named: "Plus")
        }
        else {
            cell.badgeImage.image = UIImage(named: "Minus")
        }

        cell.delegate = self
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("InfoSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
