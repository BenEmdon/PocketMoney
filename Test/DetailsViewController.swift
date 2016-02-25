//
//  DetailsViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-01-07.
//  Copyright © 2016 Ben Emdon. 
//

import UIKit


class DetailsViewController: UIViewController {
    
    @IBOutlet var cancelView: DesignableView!
    @IBOutlet var confirmView: DesignableView!
    
    @IBAction func cancelButtonDidPress(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("cancelData", object: nil)
    }
    @IBAction func confirmButtonDidPress(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("addData", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        cancelView.animation = "slideRight"
        cancelView.duration = 0.7
        cancelView.damping = 1
        cancelView.animate()
        confirmView.animation = "slideLeft"
        confirmView.duration = 0.7
        confirmView.damping = 1
        confirmView.animate()
    }
    
    override func viewWillDisappear(animated: Bool) {
        cancelView.x = -100
        cancelView.animateTo()
        confirmView.x = 100
        confirmView.animateTo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
