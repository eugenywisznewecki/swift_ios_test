//
//  Provider.swift
//  my_testProj
//
//  Created by mac-130-71 on 8/2/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

// singletone??
// TODO: - ask about Dagger2 or simply dependency injection-mirror in IOS
class Repo{

    private static var repository = Repo()
    
    
    lazy var currentUser: User? = { Auth.auth().currentUser }()
    
    static var isNatureAllowed = true
    static var isFriendsAllowed = true
    static var isDefaultAllowed = true
    
    
    private static let imagesFBPath = "images"
    private static let photosObjectcFBPath = "photos"
    
    private static let imageType = "image/jpeg"
    private static let imageExtension = ".jpeg"

    
    private var imagesStorageRef: StorageReference {
        return Storage.storage().reference()
            .child(Repo.imagesFBPath)
            .child(currentUser?.uid ?? "")
    }
    private var photoPlacesDBRef: DatabaseReference {
        return Database.database().reference()
            .child(Repo.photosObjectcFBPath)
            .child(currentUser?.uid ?? "")
    }

    
}



