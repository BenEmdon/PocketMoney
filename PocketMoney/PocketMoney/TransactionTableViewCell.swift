//
//  TransactionTableViewCell.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-04-30.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import UIKit


class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transactionColorIndicator: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
