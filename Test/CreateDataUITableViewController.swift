//
//  CreateDataUITableViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-01-11.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import UIKit
import CoreData

class CreateDataUITableViewController: UITableViewController {
    
    var amountFloat: Float! = nil
    var positive: Bool = true
    var date: NSDate!
    
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
        if inOutSegmentedController.selectedSegmentIndex == 2 {
            inOutSegmentedController.tintColor = UIColor(red:0.407, green:0.407, blue:0.407, alpha:1)
            positive = false
        }
        
    }
    
    
    @IBAction func addButtonDidPress(sender: AnyObject) {
        var sufficientData: Bool = false
        print("addDataButtonDidPress")
        if AmountTextField.text == "" {
            print("AmountTextField.text = empty")
        }
        else {
            // TODO: date = inputDate.date
            date = NSDate()
            
            print(AmountTextField.text)
            amountFloat = (AmountTextField.text! as NSString).floatValue
            sufficientData = true
        }
        
        
        
        if sufficientData {
            view.endEditing(true)
            // values.append()
            // TODO: saveValue()
            saveValue(amountFloat, positive: positive)
            self.dismissViewControllerAnimated(true, completion: nil)
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
    
    // MARK: Cancel create data
    @IBAction func cancelButtonDidPress(sender: AnyObject) {
        view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Helper Methods
    func saveValue(amount: Float, positive: Bool) {
        
        // Retrieve the managed object context in app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Add a value to the managed object context
        let entity = NSEntityDescription.entityForName("Value", inManagedObjectContext: managedContext)
        let value = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        // Set attributes
        value.setValue(amount, forKey: "amount")
        
        let amountString = amountToString(amount)
        value.setValue(amountString, forKey: "amountString")
        value.setValue(positive, forKey: "positive")
        
        // Save the managed object in context
        do {
            try managedContext.save()
        }
        catch {
            print("Could not cache the response \(error)")
        }
        
        // Add the new value to the local data source
        values.append(value)
        
        
        
    }
    
    func amountToString(value: Float) -> String {
        return "$" + String(format: "%.2f", value)
    }
    
    
    
    

}
