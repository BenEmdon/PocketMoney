//
//  TransactionController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-05-01.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import Foundation
import CoreData

class TransactionController {
    static let sharedTransactionController = TransactionController()
    var transactions: [Transaction] {
        let moc = Stack.sharedStack.managedObjectContext
        let request = NSFetchRequest(entityName: "Transaction")
        do {
            return try moc.executeFetchRequest(request) as! [Transaction]
        } catch {
            print("could not retrieve the array of Transactions")
            return []
        }
    }
    
    func createTransaction(transaction: Transaction) {
        saveToPersistentStorage()
    }
    
    func deleteTransaction(transaction: Transaction) {
        if let moc = transaction.managedObjectContext {
            moc.deleteObject(transaction)
            self.saveToPersistentStorage()
        }
    }
    
    func updateTransaction(transaction: Transaction, withTransaction: Transaction) {
        for attribute in transactions {
            if attribute == transaction {
                attribute.transactionAmount = withTransaction.transactionAmount
                attribute.moneyWasSpent = withTransaction.moneyWasSpent
                attribute.transactionDescription = withTransaction.transactionDescription
                attribute.transactionDate = withTransaction.transactionDate
            }
        }
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("could not save")
        }
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        return entriesPath
    }
}
