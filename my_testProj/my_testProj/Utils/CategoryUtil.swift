//
//  CategoryUtil.swift
//  my_testProj
//
//  Created by mac-130-71 on 8/1/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import Foundation
import UIKit

struct CategoryUtils {
    
    static func canShow(with category: Category) -> Bool {
        switch category {
        case .Nature:
            //return Repo.isNatureAllowed
            return true
        case .Friends:
            //return Repo.isFriendsAllowed
            return true
        case .Default:
            //return Repo.isDefaultAllowed
            return true
            
        default: return true
        }
    }

        
        static func pinImage(for category: Category) -> UIImage {
            return UIImage(named: CategoryUtils.getImageName(for: category))!
        }
        
        static func getTitle(for category: Category) -> String {
            switch category {
            case .Nature:
                return PhotoCategoryName.nature
            case .Friends:
                return PhotoCategoryName.friends
            case .Default:
                return PhotoCategoryName.defaults
            }
        }
        
        static func getImageName(for category: Category) -> String {
            switch category {
            case .Nature:
                return AssetsImageName.markerNature
            case .Friends:
                return AssetsImageName.markerFriends
            case .Default:
                return AssetsImageName.markerDefault
            }
        }
        
        static func getColor(for category: Category) -> UIColor {
            switch category {
            case .Nature:
                return UIColor.green
            case .Friends:
                return UIColor.yellow
            case .Default:
                return UIColor.blue
            }
        }
    }

