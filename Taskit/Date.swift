//
//  Date.swift
//  Taskit
//
//  Created by Nicholai de Guzman on 1/23/15.
//  Copyright (c) 2015 Nicholai de Guzman. All rights reserved.
//

import Foundation

class Date {
    //# allows us to show paramters when using this func
    class func from (#year:Int, month:Int, day: Int) -> NSDate {
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
        var date = gregorianCalendar?.dateFromComponents(components)
        
        
        return date!
    }
    
    class func toString(#date:NSDate) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
        
    }
    
}