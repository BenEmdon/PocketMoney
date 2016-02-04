//
//  DetailsTableView.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-02-03.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import UIKit

class DetailsTableView: UITableViewController {
    
    
    @IBOutlet var detailsHere: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        detailsHere.text = values[indexTEST].valueForKey("amountString") as? String
        print(indexTEST)
        print(values[indexTEST].valueForKey("amountString") as? String)
    }
    
    
}
