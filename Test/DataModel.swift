//
//  inOrOut.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2015-12-29.
//  Copyright © 2015 Ben Emdon. 
//

import UIKit

func amount(value: Float) -> String {
    return "$" + String(format: "%.2f", value)
}

struct Values {
    var amountString: String
    
    var positive: Bool
    
    var timeCreated: NSDate
    
    init(value: Float, positive: Bool, date: NSDate) {
        self.amountString = amount(value)
        timeCreated = date
        self.positive = positive
    }
    
}


