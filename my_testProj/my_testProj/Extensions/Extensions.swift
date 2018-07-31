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
