//
//  DetailPhotoViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/30/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {


    internal var photo: Photo?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scrollView.delegate = self as? UIScrollViewDelegate
        
        startTapGesture()

    }
    
    private func startTapGesture(){
        
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        tapDouble.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tapDouble)
        
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.require(toFail: tapDouble)
        scrollView.addGestureRecognizer(tapSingle)
        
    }
    
    @objc private func singleTap() {
       //showOrHidePanels()
    }
    
    @objc private func doubleTap(recognizer: UITapGestureRecognizer) {
        
        if(scrollView.zoomScale == scrollView.minimumZoomScale){
            let point = recognizer.location(in: scrollView)
            let size = scrollView.bounds.size
            let width = size.width/scrollView.maximumZoomScale
            let height = size.height/scrollView.maximumZoomScale
            let x = point.x - width/2.0
            let y = point.y - height/2.0
            let zone = CGRect(x: x, y: y, width: width, height: height)
            scrollView.zoom(to: zone, animated: true)
        }
        else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
        

        
        
      
    }


}
