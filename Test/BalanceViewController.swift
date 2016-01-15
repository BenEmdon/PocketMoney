//
//  BalanceViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-01-14.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {

    @IBOutlet var balanceDisplayView: DesignableView!
    @IBOutlet var balanceAmountLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        balanceAmountLabel.text = balanceAmountString()
        balanceDisplayView.animation = "slideDown"
        balanceDisplayView.animate()
    }
    
    
    // MARK: Helper methods
    
    func balanceAmountString() -> String {
        var balanceString: String!
        var balanceAmount: Float = 0
        var positive: Bool!
        var iouBool: Bool!
        var amountFloat: Float!
        
        for value in values {
            positive = value.valueForKey("positive") as! Bool
            amountFloat = value.valueForKey("amount") as! Float
            iouBool = value.valueForKey("iou") as! Bool
            if !iouBool {
                if positive == true {
                    balanceAmount += amountFloat
                }
                if positive == false {
                    balanceAmount -= amountFloat
                }
            }
        }
        
        balanceString = amountToString(balanceAmount)
        
        return balanceString
    }
    
    func amountToString(value: Float) -> String {
        if value < 0 {
            return "-$" + String(format: "%.2f", -value)
        }
        else {
            return "$" + String(format: "%.2f", value)
        }
    }
    
}
