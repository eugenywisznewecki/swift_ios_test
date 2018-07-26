//
//  DetailViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/25/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var imageView: UIImageView!
    
    
    
    var photo: Photo?
    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBAction func categoryVIewButton(_ sender: UIButton) {
        pickerView.isHidden = false
    }
    
    
    let categories = ["Friend", "Work", "Default"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if photo != nil {imageView.image = photo?.image}
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryButton.setTitle(categories[row], for: .normal)
        self.view.endEditing(true)
        pickerView.isHidden = true
    }
    
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
