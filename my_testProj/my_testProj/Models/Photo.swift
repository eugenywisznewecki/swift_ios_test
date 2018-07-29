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
    
    
    
    var name: String
    var date: Date = Date()
    var image: UIImage
    var category: Category
    
    var id: String?
    var image = UIImage()
    var url: URL?
    var latitude: Double
    var longitude: Double
    
    
    init(latitude: Double, longitude: Double){
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init (with id: String, date: Date, latitude: Double, longitude: Double){
        self.id = id
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
    }
    
}


