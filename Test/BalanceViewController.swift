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

class BalanceViewController: UIViewController, ChartViewDelegate{
    
    // MARK: - Local class variables
    var dateAxis = [String]()
    var balanceAxis = [Double]()
    
    

    // MARK: - IBOutlets
    
    @IBOutlet var balanceDisplayView: DesignableView!
    @IBOutlet var balanceAmountLabel: UILabel!
    @IBOutlet var analyticChart: LineChartView!
    @IBOutlet var viewForChart: DesignableView!
    
    
    // MARK: View did/will functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticChart.noDataText = "No data in chart"
        analyticChart.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        analyticChart.animate(xAxisDuration: 0, yAxisDuration: 1.5, easingOption: .EaseOutCubic)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        // View animations
        balanceDisplayView.animation = "slideDown"
        balanceDisplayView.animate()
        viewForChart.backgroundColor = UIColor.darkGrayColor()
        viewForChart.animation = "slideUp"
        viewForChart.animate()
        
        // Graph properties
        balanceAmountLabel.text = balanceAmountString()
        analyticChart.descriptionText = ""
        analyticChart.autoScaleMinMaxEnabled = true
        analyticChart.backgroundColor = UIColor.darkGrayColor()
        analyticChart.xAxis.labelPosition = .Bottom
        analyticChart.drawGridBackgroundEnabled = false
        analyticChart.rightAxis.enabled = false
        analyticChart.maxVisibleValueCount = 10
        analyticChart.gridBackgroundColor = UIColor.darkGrayColor()
        analyticChart.leftAxis.drawGridLinesEnabled = true
        analyticChart.leftAxis.labelTextColor = UIColor.whiteColor()
        analyticChart.xAxis.labelTextColor = UIColor.whiteColor()
        analyticChart.xAxis.drawGridLinesEnabled = false
        analyticChart.drawGridBackgroundEnabled = true
        analyticChart.pinchZoomEnabled = false
        analyticChart.doubleTapToZoomEnabled = false
        analyticChart.legend.textColor = UIColor.whiteColor()

        
        
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
            var dataEntries: [ChartDataEntry] = []
            
            
            for index in 0..<dates.count {
                let dataEntry = ChartDataEntry(value: balances[index], xIndex: index)
                dataEntries.append(dataEntry)
            }
            let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Balance")
            // Data properties
            chartDataSet.drawCubicEnabled = true
            chartDataSet.cubicIntensity = 0.2
            chartDataSet.drawCirclesEnabled = true
            chartDataSet.setCircleColor(UIColor(red:0.329, green:0.881, blue:0.481, alpha:1))
            chartDataSet.lineWidth = 1.8
            chartDataSet.circleRadius = 4.0
            chartDataSet.fillColor = UIColor(red:0.329, green:0.881, blue:0.481, alpha:1)
            chartDataSet.setColor(UIColor(red:0.329, green:0.881, blue:0.481, alpha:1))
            chartDataSet.drawVerticalHighlightIndicatorEnabled = false
            chartDataSet.drawHorizontalHighlightIndicatorEnabled = false
            chartDataSet.drawFilledEnabled = true
            chartDataSet.valueTextColor = UIColor.whiteColor()
            //chartDataSet.fillAlpha = 1
            
            
            
            let chartData = LineChartData(xVals: dateAxis, dataSet: chartDataSet)
            analyticChart.data = chartData
        }
    }
    
    
    // MARK: Helper methods
    
    // Sets balance and date axis arrays
    func setAxisArrays() {
        var instantaneousBalance: Double = 0.0
        var date: NSDate
    
        
        for value in values.reverse() {
            
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

            dateAxis.append(timeAgoSinceDate(date))
        }
        
        
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
    
    
    func timeAgoSinceDate(date:NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components: NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 1) {
            return "\(components.year)y"
        }
        else if (components.month >= 1) {
            return "\(components.month)m"
        }
        else if (components.weekOfYear >= 1) {
            return "\(components.weekOfYear)w"
        }
        else if (components.day >= 1) {
            return "\(components.day)d"
        }
        else if (components.hour >= 1) {
            return "\(components.hour)h"
        }
        else if (components.minute >= 1) {
            return "\(components.minute)min"
        }
        else if (components.second >= 3) {
            return "\(components.second)s"
        }
        else {
            return "now"
        }
    }
}
