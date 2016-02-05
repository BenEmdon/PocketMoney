//
//  DetailsTableView.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-02-03.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import UIKit

class DetailsTableView: UITableViewController {
    
    
    @IBOutlet var amountStringLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        amountStringLabel.text = values[indexSelected].valueForKey("amountString") as? String
        print(indexSelected)
        print(values[indexSelected].valueForKey("amountString") as? String)
    }
    
    
}
