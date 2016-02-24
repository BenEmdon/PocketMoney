//
//  DetailsViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-01-07.
//  Copyright © 2016 Ben Emdon. 
//

import UIKit


class DetailsViewController: UIViewController {
    
    @IBAction func cancelButtonDidPress(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("cancelData", object: nil)
    }
    @IBAction func confirmButtonDidPress(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("addData", object: nil)
    }
    
    override func viewDidLoad() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
