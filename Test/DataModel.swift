//
//  inOrOut.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2015-12-29.
//  Copyright © 2015 Ben Emdon. 
//

import UIKit

func amountToString(value: Float) -> String {
    return "$" + String(format: "%.2f", value)
}

struct Values {
    var amount:Float!
    var amountString: String
    
    var positive: Bool
    
    var timeCreated: NSDate
    
    init(value: Float, positive: Bool, date: NSDate) {
        self.amount = value
        self.amountString = amountToString(value)
        self.timeCreated = date
        self.positive = positive
    }
    
}


