//
//  PhotoViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/20/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet var photoImage: UIImageView!
    var photo: Photo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if photo != nil {
             photoImage.image = photo?.image
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
