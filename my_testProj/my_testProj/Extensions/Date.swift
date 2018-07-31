//
//  Date.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/31/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import Foundation



extension Date {
    
    var monthString: String  { return Formatter.monthString.string(from: self) }
    
    var monthInt: Int { return Int(Formatter.monthInt.string (from:self))! }
    var yearInt: Int { return Int(Formatter.year.string(from: self))!}
    
    static func from(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date:Date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    static func parse(_ string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
        return date
    }
    
    static func normalDate(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let myStringafd = formatter.string(from: yourDate!)
        
        print(myStringafd)
        
        return myStringafd
        
    }
    
    public func monthYearDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        let monthYearDatePattern = "MMMM yyyy"
        dateFormatter.dateFormat = monthYearDatePattern
        print("moth+year: \(dateFormatter.string(from: self))")

        return dateFormatter.string(from: self)
    }
}
