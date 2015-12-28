//
//  StoriesTableViewController.swift
//  Test
//
//  Created by Benjamin Emdon on 2015-12-27.
//  Copyright © 2015 Ben Emdon. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent ,animated: true)    //Depreciated  */
    }
    
    @IBAction func menuButtonDidPress(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell")! as! StoryTableViewCell
        
        cell.amountTitle.text = "$42.0"
        cell.badgeImage.image = UIImage(named: "Minus")

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("InfoSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
