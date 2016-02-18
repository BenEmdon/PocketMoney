//
//  CreateDataUITableViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-01-11.
//  Copyright © 2016 Ben Emdon.
//

import UIKit
import CoreData

class CreateDataUITableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Local class variables
    var positive: Bool = true //
    var amountFloat: Float! = nil //
    var iouBool = false
    var date = NSDate()
    var shortDescription: String! = nil
    
    // MARK: - IBOutlets in the order that they appear
    @IBOutlet var inOutSegmentedController: UISegmentedControl!
    @IBOutlet var AmountTextField: UITextField!
    @IBOutlet var iouSwitch: UISwitch!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UITextField!
    
    
    // MARK: - IBActions
    
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
    
    
    
    
    @IBAction func addButtonDidPress(sender: AnyObject) {
        print("addDataButtonDidPress")
        
        if AmountTextField.text == "" {
            print("AmountTextField.text = empty")
        }
        else {
            // TODO: date = inputDate.date
            // date = NSDate()
            
            print(AmountTextField.text)
            
            
            
            amountFloat = (AmountTextField.text! as NSString).floatValue
            iouBool = iouSwitch.on
            shortDescription = descriptionLabel.text
            
            view.endEditing(true)
            saveValue(amountFloat, positive: positive, iou: iouBool, date: date, shortDescription: shortDescription)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: View did
    
    override func viewWillAppear(animated: Bool) {
        if indexSelected != -1 {
            if (values[indexSelected].valueForKey("positive") as! Bool) {
                inOutSegmentedController.selectedSegmentIndex = 0
            }
            else {
                inOutSegmentedController.selectedSegmentIndex = 1
                inOutSegmentedController.tintColor = UIColor(red:0.875, green:0.365, blue:0.356, alpha:1)
            }
            
            AmountTextField.text = String(values[indexSelected].valueForKey("amount") as! Float)
            
            if (values[indexSelected].valueForKey("iou") as! Bool) {
                iouSwitch.on = true
            }
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/mm/yy hh:mm"
            
            dateLabel.text = dateFormatter.stringFromDate((values[indexSelected].valueForKey("transactionDate") as? NSDate)!)
            descriptionLabel.text = values[indexSelected].valueForKey("descriptionString") as? String
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.layer.cornerRadius = 8;
        
        
        self.descriptionLabel.delegate = self;
        
        // Format date
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.FullStyle
        formatter.timeStyle = .ShortStyle
        let dateString = formatter.stringFromDate(date)
        dateLabel.text = dateString
        
        // Tap anywhere recognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(tap)
    }
    
    
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: Cancel create data
    @IBAction func cancelButtonDidPress(sender: AnyObject) {
        descriptionLabel.resignFirstResponder()
        view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Helper Methods
    func saveValue(amount: Float, positive: Bool, iou: Bool, date: NSDate, shortDescription: String?) {
        
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
        value.setPrimitiveValue(iouBool, forKey: "iou")
        value.setValue(date, forKey: "transactionDate")
        value.setValue(shortDescription, forKey: "descriptionString")
       
        
        // Save the managed object in context
        do {
            try managedContext.save()
        }
        catch {
            print("Could not cache the response \(error)")
        }
        
        // Add the new value to the local data source
        if indexSelected == -1 {
            values = [value] + values
        }
        else { 
            values[indexSelected] = value
        }
        
    }
    
    func amountToString(value: Float) -> String {
        return "$" + String(format: "%.2f", value)
    }
    
    
    
    

}
