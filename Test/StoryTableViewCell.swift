//
//  StoryTableViewCell.swift
//  Test
//
//  Created by Benjamin Emdon on 2015-12-27.
//  Copyright © 2015 Ben Emdon. 
//

import UIKit

protocol StoryTableViewCellDelegate: class {
}

class StoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var colorViewDescription: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var iOUShower: DesignableView!
    
    weak var delegate: StoryTableViewCellDelegate?
    
}
