//
//  Photo.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/20/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import Foundation
import UIKit

struct Photo{
    var id: String?
    var url: String?
    var name: String?
    var date: Date = Date()
    var image: UIImage? = UIImage()
    var category: Category = .Default
    var latitude: Double
    var longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(id: String, date: Date, latitude: Double, longitude: Double) {
        self.id = id
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    init(id: String?,
         url: String?,
         name: String?,
         date: Date,
         image: UIImage?,
         category: Category,
         latitude: Double,
         longitude: Double){
        
        self.id = id
        self.name = name
        self.url = url
        self.date = date
        self.image = image
        self.category = category
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
}

//
//    var url: URL?
//    var latitude: Double = 43.000
//    var longitude: Double = 53.000
//
//
//    init(latitude: Double, longitude: Double){
//        self.latitude = latitude
//        self.longitude = longitude
//    }
//



