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
    //@IBOutlet weak var badgeImage: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: StoryTableViewCellDelegate?
    
}
