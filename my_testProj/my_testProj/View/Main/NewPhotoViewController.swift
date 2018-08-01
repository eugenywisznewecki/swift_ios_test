//
//  NewPhotoViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/31/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

// [WARN ] TODO: TASK - make this in XIB-way!

class NewPhotoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    var photo: Photo?
    let categories = [Category.Default.rawValue, Category.Friends.rawValue, Category.Nature.rawValue]
        
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var markerView: UIImageView!
    
    @IBOutlet weak var categoryViewText: UITextField!
    
    @IBOutlet weak var editTextView: UITextView!
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        
                let samplePhoto =  Photo(
                    name: editTextView.text,
                    date: Date(),
                    image: imageView.image!,
                    category: .Friends
                )
                print(samplePhoto)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //gesturePhoto to func
        let didClick = #selector(didClickImage(_:))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: didClick)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        //sets the photo
        if (photo?.image) != nil {
            imageView.image = photo!.image
        }
        
        editTextView.delegate = self
        
        //sets the text
        editTextView.layer.cornerRadius = 2
        editTextView.layer.borderColor = UIColor.gray.cgColor
        editTextView.layer.borderWidth = 1
        editTextView.tintColor = UIColor.lightGray
        
        //sets categoryPicker
        let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.backgroundColor = UIColor.white
        categoryViewText.inputView = categoryPicker
        let index = categories.index(of: photo!.category.rawValue)!
        categoryPicker.selectRow(index, inComponent: 0, animated: true)
        update(with: photo!.category)
        createToolbarForCategoryPicker()

    }
    
    private func update(with category: Category){
        markerView.image = UIImage(named: CategoryUtils.getImageName(for: category))
        categoryViewText.text = CategoryUtils.getTitle(for: category).uppercased()
        photo?.category = category
    }
    
    private func createToolbarForCategoryPicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor.lightGray
        toolbar.tintColor = UIColor.white
        let toolbarDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissModalView))
        toolbar.setItems([toolbarDoneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        categoryViewText.inputAccessoryView = toolbar
    }
    
    @objc private func dismissModalView(){
        self.view.endEditing(true)
    }
    
    
    @objc func didClickImage(_ sender: UIGestureRecognizer) {
        
        let detailPhotoViewController = UIStoryboard(name: "DetailPhoto", bundle: nil).instantiateViewController(withIdentifier: "DetailPhotoViewController") as! DetailPhotoViewController
        detailPhotoViewController.photo = photo!
        self.modalPresentationStyle = .fullScreen
        let rootNavigationController = UINavigationController(rootViewController: detailPhotoViewController)
        present(rootNavigationController, animated: true)
    }
    
    //MARK: -picker methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let category = categories[row]
        return CategoryUtils.getTitle(for: Category(rawValue: category)!).uppercased()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let chosenCategory = categories[row]
        update(with: Category(rawValue: chosenCategory)!)
    }
    
    //MARK: - textEdit methods
    func textViewDidChange(_ textView: UITextView) {
        photo?.name = editTextView.text
    }
    
    
}
