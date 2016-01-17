//
//  BalanceViewController.swift
//  PocketMoney
//
//  Created by Benjamin Emdon on 2016-01-14.
//  Copyright © 2016 Ben Emdon. All rights reserved.
//

import UIKit
import CoreData
import Charts

class BalanceViewController: UIViewController {
    
    // MARK: - Local class variables
    var dateAxis = [String]()
    var balanceAxis = [Double]()
    
    

    // MARK: - IBOutlets
    
    @IBOutlet var balanceDisplayView: DesignableView!
    @IBOutlet var balanceAmountLabel: UILabel!
    @IBOutlet var analyticChart: BarChartView!
    @IBOutlet var viewForChart: DesignableView!
    
    
    // MARK: View did/will functions
    
    override func viewDidLoad() {
        analyticChart.noDataText = "No data in chart"
    }
    
    
    override func viewWillAppear(animated: Bool) {
        // View animations
        balanceDisplayView.animation = "slideDown"
        balanceDisplayView.animate()
        viewForChart.animation = "slideUp"
        viewForChart.animate()
        
        balanceAmountLabel.text = balanceAmountString()
        
        
        dateAxis = [String]()
        balanceAxis = [Double]()
        
        setAxisArrays()
        print(dateAxis)
        print(balanceAxis)
        setChart(dateAxis, balances: balanceAxis)
        
    }
    
    
    func setChart(dates: [String], balances: [Double]) {
        print(balances[0])
        analyticChart.noDataText = "You need to record some transactions!"
        var dataIsInitialized = false
        
        if dates.count > 0 && balances.count > 0 {
            dataIsInitialized = true
        }
        
        
        if dataIsInitialized {
            var dataEntries: [BarChartDataEntry] = []
            
            
            for index in 0..<dates.count {
                let dataEntry = BarChartDataEntry(value: balances[index], xIndex: index)
                dataEntries.append(dataEntry)
            }
            let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
            let chartData = BarChartData(xVals: dateAxis, dataSet: chartDataSet)
            analyticChart.data = chartData
        }
    }
    
    
    // MARK: Helper methods
    
    // Sets balance and date axis arrays
    func setAxisArrays() {
        var instantaneousBalance: Double = 0.0
        var valuesFromLastTen = [NSManagedObject]()
        let transactionCount = values.count
        
        if transactionCount >= 10 {
            for index in 0...9 {
                valuesFromLastTen.append(values[index])
            }
        }
        else {
            for index in 0..<transactionCount {
                valuesFromLastTen.append(values[index])
            }
        }
        
        var date: NSDate
        
        for value in valuesFromLastTen.reverse() {
            
            let positive = value.valueForKey("positive") as! Bool
            let amountDouble = Double(value.valueForKey("amount") as! Float)
            let iouBool = value.valueForKey("iou") as! Bool
            
            if !iouBool {
                if positive == true {
                    instantaneousBalance += amountDouble
                }
                if positive == false {
                    instantaneousBalance -= amountDouble
                }
            }
            
            balanceAxis.append(instantaneousBalance)
            
            date = value.valueForKey("transactionDate") as! NSDate

            dateAxis.append(timeAgoSinceDate(date, numericDates: true))
        }
        
        
    }
    
    // TODO: unused
    func timeLessThanOrEqual(date1: NSDate, date2: NSDate) -> Bool {
        return date1.timeIntervalSince1970 <= date2.timeIntervalSince1970
    }
    
    
    // Gets balance amount 
    func balanceAmountString() -> String {
        var balanceString: String!
        var balanceAmount: Float = 0
        var positive: Bool!
        var iouBool: Bool!
        var amountFloat: Float!
        
        for value in values {
            positive = value.valueForKey("positive") as! Bool
            amountFloat = value.valueForKey("amount") as! Float
            iouBool = value.valueForKey("iou") as! Bool
            
            if !iouBool {
                if positive == true {
                    balanceAmount += amountFloat
                }
                if positive == false {
                    balanceAmount -= amountFloat
                }
            }
        }
        
        balanceString = amountToString(balanceAmount)
        return balanceString
    }
    
    // Formats balance Float to String
    func amountToString(value: Float) -> String {
        if value < 0 {
            return "-$" + String(format: "%.2f", -value)
        }
        else {
            return "$" + String(format: "%.2f", value)
        }
    }
    
    
    // TODO: Reduce timeAgoSinceDate
    
    func timeAgoSinceDate(date:NSDate, numericDates: Bool) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 2) {
            return "\(components.year)y"
        } else if (components.year >= 1){
            if (numericDates){
                return "1y"
            } else {
                return "Last year"
            }
        } else if (components.month >= 2) {
            return "\(components.month)m"
        } else if (components.month >= 1){
            if (numericDates){
                return "1m"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear)w"
        } else if (components.weekOfYear >= 1){
            if (numericDates){
                return "1w"
            } else {
                return "Last week"
            }
        } else if (components.day >= 2) {
            return "\(components.day)d"
        } else if (components.day >= 1){
            if (numericDates){
                return "1d"
            } else {
                return "Yesterday"
            }
        } else if (components.hour >= 2) {
            return "\(components.hour)h"
        } else if (components.hour >= 1){
            if (numericDates){
                return "1h"
            } else {
                return "An hour ago"
            }
        } else if (components.minute >= 2) {
            return "\(components.minute)min"
        } else if (components.minute >= 1){
            if (numericDates){
                return "1min"
            } else {
                return "A minute ago"
            }
        } else if (components.second >= 3) {
            return "\(components.second)s"
        } else {
            return "<1s"
        }
    }
}
