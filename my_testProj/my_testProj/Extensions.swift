//
//  Extensions.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/24/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import Foundation

extension Formatter {
    
    static let year: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static let monthString: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    
    static let monthInt: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LL"
        return formatter
    }()
}


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
}


class DateArrayConversionHelper {
    
    static func sortDateByMonth(dateArray:[Date]) -> [[Date]] {
        
        
        //create a copy of input array and sort it
        
        var inputArray:[Date] = dateArray
        inputArray.sort()
        
        //create target data structure
        
        var resultArray:[[Date]] = [[]]
        
        //set initial variable and add it to target data structure
        
        resultArray[0].append(inputArray[0])
        var k = 0
        
        for i in 1 ..< (inputArray.count) {
            
            if (inputArray[i].yearInt == inputArray[i-1].yearInt)
                && (inputArray[i].monthInt == inputArray[i-1].monthInt) {
                resultArray[k].append(inputArray[i])
            }
            else {
                k = k+1
                resultArray.append([])
                resultArray[k].append(inputArray[i])
            }
        }
        
        return resultArray
    }
    
//    static func sortPhotosByMonth(photosArray:[Photo]) -> [Date: [Photo]] {
//
//
//        //create a copy of input array and sort it
//
//        var photoArra:[Photo] = photosArray
//     //   inputArray.sort()
//
//        //create target data structure
//
//        var resultDictionary:[Date: [Month]] = [Month: [Photo]]()
//
//        //set initial variable and add it to target data structure
//
//       //resultDictionary[0].append(photosArray[0])
//        var k = 0
//
//        for i in 1 ..< (photosArray.count) {
//
//
//
//            if (Date.parse(photosArray[i].date).yearInt == Date.parse(photosArray[i-1].date).yearInt)
//                && (Date.parse(photosArray[i].date).monthInt == Date.parse(photosArray[i-1].date).monthInt) {
//                resultDictionary[k].append(inputArray[i])
//            }
//            else {
//                k = k+1
//                resultDictionary.append([])
//                resultDictionary[k].append(inputArray[i])
//            }
//        }
//
//        return resultDictionary
//    }
    
    static func printPhotosTest(_ photoArray: [Photo]){
        
        for i in 0 ..< (photoArray.count){
            print("year + \(Date.parse(photoArray[i].date).yearInt)")
            print("month + \(Date.parse(photoArray[i].date).monthInt)")
        }

    }
    
    
    
}

let randomDates:[Date] = [Date.parse("2014-05-20"), Date.parse("2012-07-21"), Date.parse("2012-07-01"), Date.parse("2017-01-24"), Date.parse("2017-01-11"), Date.parse("2017-01-14"), Date.parse("2000-01-02"), Date.parse("2000-05-20")]

let resultData:[[Date]] = DateArrayConversionHelper.sortDateByMonth(dateArray: randomDates)
