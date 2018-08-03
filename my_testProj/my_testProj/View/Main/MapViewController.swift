//
//  FirstViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/20/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {
    
    var photo: Photo?
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var navigationButton: UIButton!
    
    private lazy var imagePicker: UIImagePickerController = { UIImagePickerController() }()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var navigationMode: MKUserTrackingMode = .follow
    private let defaultRadius = 2000.0
    
    @IBAction func categoryOnClick(_ sender: UIButton) {
        
        let catStoryboard = UIStoryboard(name: "PhotoCategories", bundle: nil).instantiateViewController(withIdentifier: "PhotoCategories") as UIViewController
        
        self.modalPresentationStyle = .fullScreen
        let rootNavigationController = UINavigationController(rootViewController: catStoryboard)
        present(rootNavigationController, animated: true)
    }
    
    
    @IBAction func cameraOnClick(_ sender: UIButton) {
        
        showPictureOption()
        
        //        if currentLocation != nil {
        //            // photo = Photo(latitude: Double(currentLocation!.coordinate.latitude), longitude: Double(currentLocation!.coordinate.longitude))
        //            showPictureOption()
        //        }
        //        else {
        //            self.showToast(with: "Have not locations", message: nil)
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - SAMPLE for testing
        Repo.SAMPLE_FUNC()
        
        //location Permission
        if CLLocationManager.locationServicesEnabled() {
            checkLocationPermissions()
        }
        
        //location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        imagePicker.delegate = self
        map.delegate = self
        
        //moving the map
        if let userLocation = locationManager.location {
            move(to: userLocation, with: defaultRadius)
            map.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        }
        
        checkLocationStatusAuth()
        
        setGestuesForMap()
        
    }
    
    var currentLocation: CLLocation? = nil {
        didSet{
            map.showsUserLocation = currentLocation != nil ? true : false
            if navigationMode == .follow && map.showsUserLocation
            {
                map.setCenter(currentLocation!.coordinate, animated: true)
            }
        }
    }
 
    
    func showPictureOption(){
        let alertController = UIAlertController(title: nil, message: nil,
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Take a picture", style: .default, handler: startCamera))
        alertController.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: getImageFromLibrary))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
    
    func startCamera(_ action: UIAlertAction) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            self.showToast(with: "Have not camera", message: nil)
            return
        }
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func getImageFromLibrary(_ action: UIAlertAction){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }

    
    private func  setGestuesForMap(){
        //longPress
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(gesture:)))
        longPressGesture.minimumPressDuration = 1.0
        map.addGestureRecognizer(longPressGesture)
        
        //drag
        let didDragMap = #selector(didDragMap(_:))
        let mapDragRecognizer = UIPanGestureRecognizer(target: self, action: didDragMap)
        mapDragRecognizer.delegate = self
        self.map.addGestureRecognizer(mapDragRecognizer)
        
    }
    
    @objc func didDragMap(_ sender: UIGestureRecognizer){
        if (navigationMode == .follow && sender.state == .began ) {
            setNavigationMode(mode: .none)
        }
    }
    
    func setNavigationMode(mode: MKUserTrackingMode) {
        navigationMode = mode
        updateNavigationMode()
    }
    
    private func updateNavigationMode() {
        if navigationMode == .follow {
            switchToFollowMode()
        } else {
            switchToDiscoverMode()
        }
    }
    
    private func switchToFollowMode() {
        map.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        if let currentPosition = locationManager.location {
            move(to: currentPosition, with: defaultRadius)
        }
        navigationButton.isSelected = true
        navigationButton.tintColor = UIColor.blue
        map.selectedAnnotations.forEach { (annotation) in
            map.deselectAnnotation(annotation, animated: true)
        }
    }
    
    private func switchToDiscoverMode() {
        navigationButton.isSelected = false
        map.setUserTrackingMode(MKUserTrackingMode.none, animated: true)
        navigationButton.tintColor = UIColor.brown
    }
    
    private func move(to location: CLLocation, with regionRadious: CLLocationDistance) {
        let regionCoordinates = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadious, regionRadious)
        map.setRegion(regionCoordinates, animated: true)
    }
    
    @objc func addAnnotationOnLongPress(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .ended {
            let point = gesture.location(in: map)
            let coordinate = map.convert(point, toCoordinateFrom: map)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "new point"
            map.addAnnotation(annotation)
            
            showPictureOption()
        }
    }
    
    //MARK:- segue jumps
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newPhotoController = segue.destination as? NewPhotoViewController {
            newPhotoController.photo = self.photo
        }
    }
    
    //MARK: - ImagePICKER here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photo = Photo(id: "1",
                               url: "unknown",
                               name: "photo3 #tag",
                               date: Date.parse("2014-02-28 06:50:16"),
                               image: UIImage(named: "download")!,
                               category: Category.Default,
                               latitude: 53.0,
                               longitude: 53.0)
            
            
            
            
            dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "newPhotoDetail", sender: self)
        }
    }
    
    
    // from SOF - TODO: read about this
    private func checkLocationPermissions() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            if let userLocation = locationManager.location{
                self.currentLocation = userLocation
            }
        case .denied, .restricted:
            locationManager.startUpdatingLocation()
            currentLocation = nil
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func checkLocationStatusAuth() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            map.showsUserLocation = false
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

}

