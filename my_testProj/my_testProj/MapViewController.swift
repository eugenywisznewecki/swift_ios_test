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
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var map: MKMapView!
    
    
    @IBAction func cameraButton(_ sender: UIButton) {
        
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
//        var uilr = UILongPressGestureRecognizer(target: self, action: #selector(MKMapView.addAnnotation(_:)))
//        uilr.minimumPressDuration = 1.0
//
//
//        map.addGestureRecognizer(uilr)
        

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

            //            imageView.contentMode = .scaleAspectFit
//            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
   
    
    
}

