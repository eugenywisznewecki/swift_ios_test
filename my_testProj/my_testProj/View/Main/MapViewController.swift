//
//  FirstViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/20/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photo: Photo?
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var navigationButton: UIButton!
    
    private var imagePicker = UIImagePickerController()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var navigationMode: MKUserTrackingMode = .follow
    private let defaultRadius = 2000.0
    
    var currentLocation: CLLocation? = nil {
        didSet{
            map.showsUserLocation = currentLocation != nil ? true : false
            if navigationMode == .follow && map.showsUserLocation
            {
                  map.setCenter(currentLocation!.coordinate, animated: true)
            }
        }
    }
    
    @IBAction func categoryOnClick(_ sender: UIButton) {
        
        let catStoryboard = UIStoryboard(name: "PhotoCategories", bundle: nil).instantiateViewController(withIdentifier: "PhotoCategories") as UIViewController
        
        self.modalPresentationStyle = .fullScreen
        let rootNavigationController = UINavigationController(rootViewController: catStoryboard)
        present(rootNavigationController, animated: true)
    }
    
  
    
    @IBAction func cameraOnClick(_ sender: UIButton) {
         showPictureOption()
    }
    
    func showPictureOption(){
        let alertController = UIAlertController(title: "some title", message: "some message",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Take a picture", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: {
            ( action: UIAlertAction!) in self.choosePhoto()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
    
    func choosePhoto(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(53.888381, 27.544470)
        let region = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "title annotation"
        annotation.subtitle = "subtitle"
        map.addAnnotation(annotation)

        
        //longPress
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(gesture:)))
        longPressGesture.minimumPressDuration = 1.0
        map.addGestureRecognizer(longPressGesture)
        
        
    }
    
    @objc func addAnnotationOnLongPress(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .ended {
            let point = gesture.location(in: map)
            let coordinate = map.convert(point, toCoordinateFrom: map)
            
            print(coordinate)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = coordinate

            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let controller = storyboard.instantiateViewController(withIdentifier: "DetailController")
            //self.present(controller, animated: true, completion: nil)
            
            showPictureOption()
            
            annotation.title = "new title"
            annotation.subtitle = "new subtitle"
            map.addAnnotation(annotation)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailController = segue.destination as? DetailViewController {
            detailController.photo = self.photo
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            

//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = DetailViewController()

            photo = Photo(name: "photoNEW",
                               date: Date.parse("2018-11-11 06:50:16"),
                               image: pickedImage,
                               category: Category.Default)

        }

        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "DetailSegue", sender: self)

    }
}

