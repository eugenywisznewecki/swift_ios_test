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
    
    private static var currentRepo = Repo()
    
    lazy var currentUser: User? = { Auth.auth().currentUser }()
    
    lazy var imagesFilesStorageReference: StorageReference  = {
        Storage.storage().reference()
            .child(Repo.imagesFBPath)
            .child(currentUser?.uid ?? "")
    }()
    
    lazy var photoBeansDBReference: DatabaseReference  = {
        return Database.database().reference()
            .child(Repo.photosObjectcFBPath)
            .child(currentUser?.uid ?? "")
    }()

    
    static var isNatureAllowed = true
    static var isFriendsAllowed = true
    static var isDefaultAllowed = true
    
    
    private static let imagesFBPath = "images"
    private static let photosObjectcFBPath = "photos"
    
    private static let IMAGE_TYPE = "image/jpeg"
    private static let IMAGE_EXTENSION = ".jpeg"

    
    static func uploadImageToStorageFB(image: UIImage){
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let metaData = StorageMetadata()
        metaData.contentType = IMAGE_TYPE
        let imageName = "\(UUID().uuidString)\(IMAGE_EXTENSION)"
        currentRepo.imagesFilesStorageReference.child(imageName).putData(imageData!, metadata: metaData, completion: nil)

    }
    
    static func uploaPhotodBean(){
        
    }
    
    static func getAllPhotos(){
        
    }
    
    static func savePhoto(){
        
    }
    
    //TODO: delete this
    static func SAMPLE_FUNC(){
        
        let photo33 = Photo(name: "photo3 #tag",
                            date: Date.parse("2014-04-28 06:50:16"),
                            image: UIImage(named: "download3")!,
                            category: Category.Friends)
        
        uploadImageToStorageFB(image: photo33.image!)

    }

}



