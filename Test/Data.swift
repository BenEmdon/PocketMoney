//
//  inOrOut.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2015-12-29.
//  Copyright © 2015 Ben Emdon. All rights reserved.
//

import UIKit

func amount(value: Float) -> String {
    return "$" + String(format: "%.2f", value)
}

struct Values {
    var amountString: String
    
    var positive: Bool
    
    var timeCreated: NSDate
    
    init(value: Float, positive: Bool) {
        self.amountString = amount(value)
        timeCreated = NSDate()
        self.positive = positive
    }
    
}

