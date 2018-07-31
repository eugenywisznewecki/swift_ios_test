//
//  CategoryViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/31/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var sections = [String]()
    private var photosbySection = [String : [Photo]]()
    private var photosWithTag = [Photo]()
    
    private var photoArray = [Photo]()
    
    @IBAction func categoryClick(_ sender: UIButton) {
        //categoryChooser show modally
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let photo1 = Photo(name: "photo1",
                           date: Date.parse("2016-02-02 03:03:16"),
                           image: UIImage(named: "download")!,
                           category: Category.Friends )
        
        photosWithTag.append(photo1);
        
        let photo2 = Photo(name: "photo2",
                           date: Date.parse("2015-05-14 03:16:16"),
                           image: UIImage(named: "download1")!,
                           category: Category.Nature)
        photosWithTag.append(photo2);
        
        let photo3 = Photo(name: "photo3",
                           date: Date.parse("2014-04-28 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Friends)
        photosWithTag.append(photo3);
        
        
        let photo4 = Photo(name: "photo4",
                           date: Date.parse("2015-01-14 03:16:16"),
                           image: UIImage(named: "download1")!,
                           category: Category.Nature)
        photosWithTag.append(photo4);
        
        let photo33 = Photo(name: "photo3",
                           date: Date.parse("2014-04-28 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Friends)
        photosWithTag.append(photo33);
        
        
        let photo43 = Photo(name: "photo4",
                           date: Date.parse("2015-01-14 03:16:16"),
                           image: UIImage(named: "download1")!,
                           category: Category.Nature)
        photosWithTag.append(photo43);
        
        
        let photo5 = Photo(name: "photo5",
                           date: Date.parse("2011-02-12 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Default)
        photosWithTag.append(photo5);
        
        
        dividePhotosIntoSections(from: photosWithTag)
        
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
        
        print("by sections : \(photosbySection)")
    }
    
    private func updateViewTable(with photoIn: [Photo]){
        dividePhotosIntoSections(from: photoIn)
        
        if (isFilterNow()){
            filterPhotosToShow(for: searchView.text!)
        }
    }
    
    private func filterPhotosToShow(for searchText: String){
        let searchTags = makeSearchTagsFromText(for: searchText)
        for (_, photos) in photosbySection {
            let filtered = photos.filter({ (photo) -> Bool in
                return isHasTags(in: photo.name, tags: searchTags)
            })
            filtered.forEach({photosWithTag.append($0)})
        }
    }
    
    private func isHasTags(in text: String?, tags: [String]) -> Bool {

        guard text != nil, !tags.isEmpty else {
            return false
        }
       for tag in tags {
            if text!.lowercased().contains(tag.lowercased()) {
                return true
            }
        }
        return false
    }
    
    private func isFilterNow() -> Bool {
        if((searchView.text?.isEmpty)!) {
            return false
        }
        else {return true}
      
    }
    
    // WARN - makes tags from everything
    private func makeSearchTagsFromText(for findText: String) -> [String]{
        let findTags = findText
        
        var tags = findTags.components(separatedBy: " ").filter { !$0.isEmpty }
        
        tags = tags.compactMap { (tag) -> String in
            if tag.first == "#" {
                return tag
            }
            else {
                return "#\(tag)"
            }
        }
        print(tags)
        return tags
    }

    private func footer(){
         let footer = UIView()
         footer.backgroundColor = UIColor.white.withAlphaComponent(0.0)
         tableView.tableFooterView = footer
    }
    
    
    //MARK: - table methods of
    //++
    func numberOfSections(in tableView: UITableView) -> Int {
//        if isFilterNow() {
//            return photosWithTag.isEmpty ? 0 : 1
//        }
        
        print("keys sections: \(photosbySection)")
        return photosbySection.keys.count
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFilterNow() {
//            return photosWithTag.count
//        }
        let sectionKey = sections[section]

        print("sectionKey : \(sectionKey)")
       
        return photosbySection[sectionKey]?.count ?? 0
    }
    
    
    //header title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
//        if isFilterNow(){
//            return nil
//        }
        let sectionKey = sections[section]
        print("sectionKey: \(sectionKey)")
        return sectionKey
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      
        //
        
        let section = sections[indexPath.section]
        
        
//        if let sectionPhotos = photosbySection[section], indexPath.row < sectionPhotos.count {
//
//            let photo = Photo[row]
//            ImageLoadUtils.loadWithPlaceholder(for: cell.photoThumbnail, from: photoPlace.url!, mode: .aspectFill)
//            cell.titleLabel.text = photoPlace.title
//            let categoryTitle = CategoryUtils.getTitle(for: photoPlace.category).uppercased()
//            cell.descriptionLabel.text = "\(photoPlace.date.shortDate()) / \(categoryTitle)"
//        }
        
   
       // let photo = photosbySection[indexPath.]     [indexPath.row]
        //cell.textLabel?.text = photo.name
        //cell.detailTextLabel.text = Date.normalDate(date: photo.date)
        
        //cell.textLabel3?.text = photo.category.rawValue
        //cell.imageView?.image = photo.image
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
