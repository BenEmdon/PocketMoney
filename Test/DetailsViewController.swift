//
//  DetailsViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-01-07.
//  Copyright © 2016 Ben Emdon. 
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var tempLabel: UILabel!
    
    var numberToDisplay = -100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempLabel.text = "The numberToDisplay =  \(numberToDisplay)."

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
