//
//  StoryTableViewCell.swift
//  Test
//
//  Created by Benjamin Emdon on 2015-12-27.
//  Copyright © 2015 Ben Emdon. All rights reserved.
//

import UIKit

protocol StoryTableViewCellDelegate: class {
}

class StoryTableViewCell: UITableViewCell {

    @IBOutlet var badgeImage: UIImageView!
    @IBOutlet var amountLabel: UILabel!
    


}
