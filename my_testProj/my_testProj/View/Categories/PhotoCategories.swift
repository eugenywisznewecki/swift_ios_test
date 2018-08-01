//
//  PhotoCategoriesViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 8/1/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class PhotoCategories: UIViewController {


    @IBOutlet weak var natureButton: UIButton!
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var defaultButton: UIButton!
    
    @IBAction func didDoneButtonClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didNatureCategoryClick(_ sender: UIButton) {

        updateState(for: sender)
    }
    
    @IBAction func didFriendsCategoryClick(_ sender: UIButton) {

        updateState(for: sender)
    }
    
    @IBAction func didDefaultCategoryClick(_ sender: UIButton) {

        updateState(for: sender)
    }
    
    private func setupButtons() {
        setUp(button: natureButton, with: .Nature)
        setUp(button: friendsButton, with: .Friends)
        setUp(button: defaultButton, with: .Default)
    }
    
    private func setUp(button: UIButton, with category: Category){
        let buttonColor = CategoryUtils.getColor(for: category)
        let isSelected = CategoryUtils.canShow(with: category)
        button.isSelected = isSelected
        button.layer.cornerRadius = button.frame.width / 2.0
        button.layer.borderColor = buttonColor.cgColor
        button.layer.borderWidth = isSelected ? button.frame.width : 2
    }
    
    private func updateState(for button: UIButton) {
        button.layer.borderWidth = button.isSelected ? button.frame.width : 2
    }
    
    private func roundedImageWithBorder(sideSize: CGFloat, color: UIColor, isFilled: Bool = false) -> UIImage? {
        let square = CGSize(width: sideSize, height: sideSize)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .center
        imageView.layer.cornerRadius = square.width / 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = color.cgColor
        if isFilled {
            imageView.layer.backgroundColor = color.cgColor
        }
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
