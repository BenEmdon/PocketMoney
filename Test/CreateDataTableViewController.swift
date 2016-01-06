//
//  CreateDataTableViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-01-06.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import UIKit

class CreateDataTableViewController: UITableViewController {

    var amountString: Float! = nil
    var positive: Bool = true
    
    @IBOutlet var AmountTextField: UITextField!
    
    
    @IBOutlet var inOutSegmentedController: UISegmentedControl!
    @IBAction func inOutSegmentedControllerAction(sender: AnyObject) {
        
        if inOutSegmentedController.selectedSegmentIndex == 0 {
            inOutSegmentedController.tintColor = UIColor(red:0.329, green:0.881, blue:0.481, alpha:1)
            positive = true
        }
        if inOutSegmentedController.selectedSegmentIndex == 1 {
            inOutSegmentedController.tintColor = UIColor(red:0.875, green:0.365, blue:0.356, alpha:1)
            positive = false
        }
    }
    
    
    @IBAction func addBarButtonItemDidPress(sender: AnyObject) {
        var sufficientData: Bool = false
        print("addDataButtonDidPress")
        if AmountTextField.text == "" {
            print("AmountTextField.text = empty")
        }
        else {
            print(AmountTextField.text)
            amountString = (AmountTextField.text! as NSString).floatValue
            sufficientData = true
        }
        
        
        
        if sufficientData {
            AllData.dataList.append(Values(value: amountString, positive: positive))
        }
    }
    

    
    override func viewDidLoad() {
        print("viewLoaded")
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(tap)
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
