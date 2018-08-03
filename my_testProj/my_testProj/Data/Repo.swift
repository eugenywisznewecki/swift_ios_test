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
    
    var photosForDownload = [Photo]()
    
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
    
    //keys for FBdatabase
    static let nameFB = "title"
    static let imageURLFB = "imageurl"
    static let timestampFB = "timestamp"
    static let latitudeFB = "latitude"
    static let longitudeFB = "longitude"
    static let categoryFB = "category"
    
    static func savePhoto(photo: Photo){
        //TODO: check Internet
        
        var tempPhoto = photo
        
        uploadImageToStorageFB(image: photo.image!, uploadImageHandler: {(url, error) in
            guard error == nil else {  return   }
            tempPhoto.url = url?.absoluteString ?? ""
            uploaPhotodBean(photo: tempPhoto)
        })
    }
    
    static func uploadImageToStorageFB(image: UIImage, uploadImageHandler: @escaping (URL?, Error?) -> ()){
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let metadata = StorageMetadata()
        metadata.contentType = IMAGE_TYPE
        let imageName = "\(UUID().uuidString)\(IMAGE_EXTENSION)"
        let reference = currentRepo.imagesFilesStorageReference.child(imageName)
        reference.putData(imageData!, metadata: metadata, completion: { (metadata, error) in
            reference.downloadURL( completion: { (url, error) in
                uploadImageHandler(url, error)})
        })
    }
    
    static func uploaPhotodBean(photo: Photo){
        let parametersForFB: [String : Any] =    [self.nameFB : photo.name!,
                                                  //self.imageURLFB : photo.url?.absoluteString ?? String.empty,
            self.timestampFB : Int(photo.date.timeIntervalSince1970),
            //self.latitudeFBudeKey : photo.latitude,
            //self.longitudeFBudeKey : photo.longitude,
            self.categoryFB : photo.category.rawValue]
        
        var dataBaseReference: DatabaseReference
        if photo.id != nil {
            dataBaseReference = currentRepo.photoBeansDBReference.child(photo.id!)
        } else {
            dataBaseReference = currentRepo.photoBeansDBReference.childByAutoId()
        }
        dataBaseReference.setValue(parametersForFB) { (error, dbRef) in
            if error == nil {
                var savedPhoto = photo
                savedPhoto.id = dbRef.key           //MARK: - sets the ID
            } else {
                print("error")
            }
        }
    }
    
    static func getAllPhotos() {
        currentRepo.photoBeansDBReference.observeSingleEvent(of: DataEventType.value, with: { (snapshot: DataSnapshot) in
            guard let snapshotMap = snapshot.value as? [String: Any] else {
                print("null from snaphot")
                return
            }
            for (key, properties) in snapshotMap {
                let photoSnapshot = (key, properties)
                if let photo = getPhotoFromSnapShot(from: photoSnapshot){
                    currentRepo.photosForDownload.append(photo)
                    print(photo)
                }
            }
             print("photos downloaded")
        })
    }
    
    private static func getPhotoFromSnapShot(from snapshot: (photoId: String, values: Any)) -> Photo? {
        
        guard let properties = snapshot.values as? [String: Any] else { return nil }
        
        let name = properties [nameFB] as? String
        
        let imageURLString = properties[imageURLFB] as! String
        let url = imageURLString
        
        let timestamp = properties[timestampFB] as! Int
        
        let timeInterval = TimeInterval(timestamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let latitude  = properties[latitudeFB] as! Double
        let longitude = properties[longitudeFB] as! Double
        let categoryValue = properties[categoryFB] as! String
        
        var photo =  Photo(id: snapshot.photoId, date: date, latitude: latitude, longitude: longitude)
        photo.name = name
        photo.url = url
        if let category = Category(rawValue: categoryValue) {
            photo.category = category
        }
        return photo
    }
    
    
    
    //TODO: delete this
    static func SAMPLE_FUNC(){
//        let photo33 = Photo(id: "1",
//                            url: "unknown",
//                            name: "photo3 #tag",
//                            date: Date.parse("2014-04-28 06:50:16"),
//                            image: UIImage(named: "download3")!,
//                            category: Category.Friends,
//                            latitude: 53.0,
//                            longitude: 53.0)
//               savePhoto(photo: photo33)
        
        getAllPhotos()
    }
}



