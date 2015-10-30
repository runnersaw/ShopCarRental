//
//  File.swift
//  shopcarrental
//
//  Created by Sawyer Vaughan on 10/30/15.
//  Copyright © 2015 Sawyer Vaughan. All rights reserved.
//

import Foundation

class DateHelper {
    func getDateFromDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.stringFromDate(date)
    }
    
    func getHoursFromDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH"
        return formatter.stringFromDate(date)
    }
    
    func getMinutesFromDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "mm"
        let minutes = Int(formatter.stringFromDate(date))!
        if minutes > 0 && minutes < 30 {
            return "00"
        } else {
            return "30"
        }
    }
}
