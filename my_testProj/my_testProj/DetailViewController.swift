//
//  DetailViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/25/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let categories = [Category.Default.rawValue, Category.Friends.rawValue, Category.Nature.rawValue]
    
    lazy var currDate: Date = { Date() }()
    
    @IBOutlet weak var imageView: UIImageView!
    var photo: Photo?
    
    @IBOutlet weak var editTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBAction func categoryVIewButton(_ sender: UIButton) {
        pickerView.isHidden = false
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
       
        let photo =  Photo(name: editTextView.text,
                           date: currDate,
                           image: imageView.image!,
                           category: Category(rawValue: (categoryButton.titleLabel?.text)!)!)
        
        print(photo)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if photo != nil {
            imageView.image = photo?.image
            
            //MARK:- date
            let df = DateFormatter()
            df.dateStyle = .long
            df.timeStyle = .medium
            let now = df.string(from: currDate)
            dateLabel.text = now
            
        }
        
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

}
