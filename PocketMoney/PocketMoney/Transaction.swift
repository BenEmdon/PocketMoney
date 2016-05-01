//
//  Transaction.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-05-01.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import Foundation
import CoreData


class Transaction: NSManagedObject {

    convenience init(amount: Double, moneyWasSpent: Bool, description: String, date: NSDate = NSDate(), context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entity = NSEntityDescription.entityForName("Transaction", inManagedObjectContext: context)!
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.transactionAmount = amount
        self.moneyWasSpent = moneyWasSpent
        self.transactionDescription = description
        self.transactionDate = date
    }
}
