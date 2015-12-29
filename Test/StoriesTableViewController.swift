//
//  StoriesTableViewController.swift
//  Test
//
//  Created by Benjamin Emdon on 2015-12-27.
//  Copyright © 2015 Ben Emdon. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent ,animated: true)    //Depreciated  */
        
        tableView.estimatedRowHeight = 46
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("InfoSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func menuButtonDidPress(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell")! as! StoryTableViewCell
        
        cell.amountLabel.text = "$42.0"
        cell.badgeImage.image = UIImage(named: "Minus")
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("InfoSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
