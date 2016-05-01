//
//  Transaction+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-05-01.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Transaction {

    @NSManaged var moneyWasSpent: Bool
    @NSManaged var transactionAmount: Double
    @NSManaged var transactionDate: NSDate
    @NSManaged var transactionDescription: String?

}
