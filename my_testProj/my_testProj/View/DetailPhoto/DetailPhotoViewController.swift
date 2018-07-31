//
//  DetailPhotoViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/30/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController, UIScrollViewDelegate {


    internal var photo: Photo?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: {[weak self] in
            print("closed the deltail window")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        
        let photo1 = Photo(name: "photo1",
                           date: Date.parse("2016-02-02 03:03:16"),
                           image: UIImage(named: "download")!,
                           category: Category.Friends )
        photo = photo1
        
        if (photo != nil){
            photoView.sizeToFit()
            photoView.image = photo?.image
            titleLabel.text = photo?.name
            dateLabel.text = photo?.date.monthString
            
        }

        startTapGesture()
        startUpDownViews()

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
        if (topView.isHidden && bottomView.isHidden){
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                
                self?.bottomView.alpha = 1.0
                self?.topView.alpha = 1.0
            })
            
            topView.isHidden = true
            bottomView.isHidden = true
            
        }
        else {
            UIView.animate(withDuration: 0.3, animations: {[weak self] in
                self?.bottomView.alpha = 0
                self?.bottomView.alpha = 0
            })
            topView.isHidden = false
            bottomView.isHidden = false
            
        }
        
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
    
    private func   startUpDownViews(){
        
    let backGroundColor = UIColor.black.withAlphaComponent(0.30)
    
        let gradientUp = CAGradientLayer()
        gradientUp.frame.size = topView.layer.preferredFrameSize()
        gradientUp.colors = [backGroundColor.cgColor, UIColor.clear.cgColor]
        gradientUp.locations = [0.85, 1]
        topView.layer.insertSublayer(gradientUp, at: 0)
        
        let gradientDown = CAGradientLayer()
        gradientDown.frame.size = bottomView.layer.preferredFrameSize()
        gradientDown.colors = [backGroundColor.cgColor, UIColor.clear.cgColor]
        gradientDown.locations = [0, 0.15]
        bottomView.layer.insertSublayer(gradientDown, at: 0)
        
    }
    
   
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return photoView;
    }
    
   
}


