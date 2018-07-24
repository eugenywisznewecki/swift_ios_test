//
//  FirstViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/20/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(53.888381, 27.544470)
        let region = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
 
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "title annotation"
        annotation.subtitle = "subtitle"
        map.addAnnotation(annotation)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

