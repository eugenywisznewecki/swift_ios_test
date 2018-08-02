//
//  CategoryViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/31/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

//TODO: mistake in logic
class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var sectionsAll = [String]()
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
        searchView.delegate = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        
        //SAMPLE array
        let photo1 = Photo(id: "1", url: "unknown",name: "photo1",
                           date: Date.parse("2016-02-02 03:03:16"),
                           image: UIImage(named: "download")!,
                           category: Category.Friends )
        
        photoArray.append(photo1);
        
        let photo2 = Photo(id: "1", url: "unknown",name: "photo2 222",
                           date: Date.parse("2015-05-14 03:16:16"),
                           image: UIImage(named: "download1")!,
                           category: Category.Nature)
        photoArray.append(photo2);
        
        let photo3 = Photo(id: "1", url: "unknown", name: "photo3 mmm",
                           date: Date.parse("2014-04-28 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Friends)
        photoArray.append(photo3);
        
        
        let photo4 = Photo(id: "1", url: "unknown",name: "photo4 tag",
                           date: Date.parse("2015-01-14 03:16:16"),
                           image: UIImage(named: "download1")!,
                           category: Category.Nature)
        photoArray.append(photo4);
        
        let photo33 = Photo(id: "1", url: "unknown",name: "photo3 #tag",
                           date: Date.parse("2014-04-28 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Friends)
        photoArray.append(photo33);
        
        let photo43 = Photo(id: "1", url: "unknown",name: "photo4",
                           date: Date.parse("2015-01-14 03:16:16"),
                           image: UIImage(named: "download1")!,
                           category: Category.Nature)
        photoArray.append(photo43);

        let photo5 = Photo(id: "1", url: "unknown",name: "photo5 #mmm",
                           date: Date.parse("2011-02-12 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Default)
        photoArray.append(photo5);
        
        let photo6 = Photo(id: "1", url: "unknown",name: "photo6",
                           date: Date.parse("2011-02-12 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Default)
        photoArray.append(photo6);
        
        let photo7 = Photo(id: "1", url: "unknown",name: "photo7",
                           date: Date.parse("2011-02-12 06:50:16"),
                           image: UIImage(named: "download3")!,
                           category: Category.Default)
        photoArray.append(photo7);
        
       dividePhotosIntoSections(from: photoArray)

        footer()
        definesPresentationContext = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        spinner.startAnimating()

        //downloadPhotos

        super.viewWillAppear(animated)
    }


    private func dividePhotosIntoSections(from photos: [Photo]){
        for photo in photos {
            let sectionTitle = photo.date.monthYearDate()
            if photosbySection[sectionTitle] != nil {
                photosbySection[sectionTitle]!.append(photo)
            }
            else {
                sectionsAll.append(sectionTitle)
                photosbySection[sectionTitle] = [photo]
            }
        }
        
         print("\(sectionsAll)")
         print("\(photosbySection)")
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
                return isHasTags(in: photo.name, tags: searchTags)   //search
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
    
    private func openFullPhotoView(for photo: Photo){
        let detailPhotoViewController = UIStoryboard(name: "DetailPhoto", bundle: nil).instantiateViewController(withIdentifier: "DetailPhotoViewController") as! DetailPhotoViewController
        detailPhotoViewController.photo = photo
        self.modalPresentationStyle = .fullScreen
        let rootNavigationController = UINavigationController(rootViewController: detailPhotoViewController)
        present(rootNavigationController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail"){
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! NewPhotoViewController
                destinationController.photo = photoArray[indexPath.row]
            }
        }
    }
    
    
    //MARK: - table methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsAll.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchView.resignFirstResponder()
        if isFilterNow() {
            let photo = photosWithTag[indexPath.row]
            openFullPhotoView(for: photo)
        } else {
            let sectionKey = sectionsAll[indexPath.section]
            if let sectionPhotos = photosbySection[sectionKey], indexPath.row < sectionsAll.count {
                let photo = sectionPhotos[indexPath.row]
                openFullPhotoView(for: photo)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterNow() {
            return photosWithTag.count
        }
         let sectionKey = sectionsAll[section]
         return photosbySection[sectionKey]?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFilterNow(){
            return nil
        }
        return sectionsAll[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = photoArray[indexPath.row]
        cell.imageViewCell?.image = photo.image
        cell.labelTitle.text = photo.name
        cell.laberDate.text = "\(photo.date.shortDate()) / \(photo.category.rawValue.uppercased())"
        return cell
    }
    
    //MARK: SearchMethods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        photosWithTag.removeAll()
        filterPhotosToShow(for: searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
