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
    
    
}

class DateArrayConversionHelper {
    
    static func sortDateByMonth(dateArray:[Date]) -> [[Date]] {
        
        var inputArray:[Date] = dateArray
        inputArray.sort()
        
        var resultArray:[[Date]] = [[]]
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
    
    //    static func sortPhotosByMonth(_ photosArray: [Photo]) -> [Month: [Photo]]  {
    //
    //        print("no sorted: \(photosArray)")
    //
    //        var photoArrayIn:[Photo] = photosArray.sorted(by: {$0.date < $1.date})
    //        print("/n sorted: \(photoArrayIn)")
    //
    //        var resultDictionary:[Month: [Photo]] = [Month: [Photo]]()
    //
    //
    //
    //        for i in 0..<(photoArrayIn.count){
    //            print(i)
    //
    //            var month: Month = Month(year: photoArrayIn[i].date.yearInt, month:
    //                photoArrayIn[i].date.monthInt)
    //
    //            var photosInMonth = [Photo]()
    //
    //            resultDictionary[month] =
    //
    //        }
    
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
//    return resultDictionary
//}

static func printPhotosTest(_ photoArray: [Photo]){
    
    for i in 0 ..< (photoArray.count){
        print("year + \(photoArray[i].date).yearInt)")
        print("month + \(photoArray[i].date).monthInt)")
    }
   
}



}

let randomDates:[Date] = [Date.parse("2014-05-20"), Date.parse("2012-07-21"), Date.parse("2012-07-01"), Date.parse("2017-01-24"), Date.parse("2017-01-11"), Date.parse("2017-01-14"), Date.parse("2000-01-02"), Date.parse("2000-05-20")]

let resultData:[[Date]] = DateArrayConversionHelper.sortDateByMonth(dateArray: randomDates)