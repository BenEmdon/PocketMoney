//: Playground - noun: a place where people can play

import UIKit
/*
var number: Float = 4
var str: String = String(format: "%.2f", number) + "h"

struct Player {
    var name: String?
    var game: String?
    var rating: Int
    
    init(name: String?, game: String?, rating: Int) {
        self.name = name
        self.game = game
        self.rating = rating
    }
}

var a = Player(name: "a",game: "b", rating: 2)
a.name


let date = NSDate()
date.dynamicType


func amount(value: Float) -> String {
    return "$" + String(format: "%.2f", value)
}

struct Values {
    var amountString: String
    
    var timeCreated: NSDate
    
    init(value: Float) {
        self.amountString = amount(value)
        timeCreated = NSDate()
    }
    
}

var k = Values(value: 14.309)



//MARK: Not Mine
func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
    let calendar = NSCalendar.currentCalendar()
    let now = NSDate()
    let earliest = now.earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
    
    if (components.year >= 2) {
        return "\(components.year) years ago"
    } else if (components.year >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month >= 2) {
        return "\(components.month) months ago"
    } else if (components.month >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear >= 2) {
        return "\(components.weekOfYear) weeks ago"
    } else if (components.weekOfYear >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day >= 2) {
        return "\(components.day) days ago"
    } else if (components.day >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour >= 2) {
        return "\(components.hour) hours ago"
    } else if (components.hour >= 1){
        if (numericDates){
            return "1 hour ago"
        } else {
            return "An hour ago"
        }
    } else if (components.minute >= 2) {
        return "\(components.minute) minutes ago"
    } else if (components.minute >= 1){
        if (numericDates){
            return "1 minute ago"
        } else {
            return "A minute ago"
        }
    } else if (components.second >= 3) {
        return "\(components.second) seconds ago"
    } else {
        return "Just now"
    }
    
}

var m = timeAgoSinceDate(k.timeCreated, numericDates: true)

var myBool:Bool?
myBool = true
myBool = nil
*/
let time = NSDate()
let hour = NSCalendar.currentCalendar().component(NSCalendarUnit.Hour, fromDate: time)
let minute = NSCalendar.currentCalendar().component(NSCalendarUnit.Minute, fromDate: time)

func dateToHourMinuteString(date: NSDate) -> String {
    let hour = NSCalendar.currentCalendar().component(NSCalendarUnit.Hour, fromDate: date)
    let minute = NSCalendar.currentCalendar().component(NSCalendarUnit.Minute, fromDate: date)
    let time = String(hour) + ":" + String(minute)
    return time
}

dateToHourMinuteString(time)

let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]

var i = unitsSold.maxElement()! - unitsSold.minElement()!

