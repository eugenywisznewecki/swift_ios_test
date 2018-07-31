//
//  CategoryViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/31/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    


    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var sections = [String]()
    private var photosbySection = [String : [Photo]]()
    private var photosWithTag = [Photo]()
    
    
    private var photoArray = [Photo]()
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let photo1 = Photo(name: "photo1",
                           date: Date.parse("2016-02-02 03:03:16"),
                           image: UIImage(named: "download")!,
                           category: Category.Friends )
        
        photoArray.append(photo1);
        
        let photo2 = Photo(name: "photo2",
                           date: Date.parse("2015-05-14 03:16:16"),
                           image: UIImage(named: "download1")!,
                           category: Category.Nature)
        photoArray.append(photo2);
        
        let photo3 = Photo(name: "photo3",
                           date: Date.parse("2014-04-28 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Friends)
        photoArray.append(photo3);
        
        
        let photo4 = Photo(name: "photo4",
                           date: Date.parse("2015-01-14 03:16:16"),
                           image: UIImage(named: "download1")!,
                           category: Category.Nature)
        photoArray.append(photo4);
        
        
        let photo5 = Photo(name: "photo5",
                           date: Date.parse("2011-02-12 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Default)
        photoArray.append(photo5);
        
       
        
        dividePhotosIntoSections(from: photoArray)
        
        
        footer()
        definesPresentationContext = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        spinner.startAnimating()
        
        sections.removeAll()
        photosWithTag.removeAll()
        photosbySection.removeAll()
       
        //downloadPhotos
      
        super.viewWillAppear(animated)
    }
    
    
    
    private func dividePhotosIntoSections(from photos: [Photo]){
        for photo in photos {
            let sectionTitle = photo.date.monthYearDate()
            if photosbySection[sectionTitle] != nil {
                photosbySection[sectionTitle]?.append(photo)
            }
            else {
                sections.append(sectionTitle)
                photosbySection[sectionTitle] = [photo]
            }
        }
    }
    
    private func updateViewTable(){
        
    }

    
    private func footer(){
         let footer = UIView()
         footer.backgroundColor = UIColor.white.withAlphaComponent(0.0)
         tableView.tableFooterView = footer
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // count of rows
        
        if (section == 0) {
            return 1
        }
        return photoArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let photo = photoArray[indexPath.row]
        cell.textLabel?.text = photo.name
        cell.detailTextLabel?.text = Date.normalDate(date: photo.date) + " / " + photo.category.rawValue
        cell.imageView?.image = photo.image
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail"){
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! PhotoViewController
                destinationController.photo = photoArray[indexPath.row]
            }
        }
    }

}
