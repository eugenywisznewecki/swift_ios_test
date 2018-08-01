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
    
    static func printPhotosTest(_ photoArray: [Photo]){
        
        for i in 0 ..< (photoArray.count){
            print("year + \(photoArray[i].date).yearInt)")
            print("month + \(photoArray[i].date).monthInt)")
        }
        
    }
}
