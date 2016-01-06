//
//  CreateDataTableViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-01-06.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import UIKit

class CreateDataTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(tap)
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
