//
//  CategoryViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/20/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {

    
    var photoArray = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let photo1 = Photo(name: "photo1",
                           date: "2001-20-10",
                           image: UIImage(named: "download")!,
                           tag: "family")
        
        photoArray.append(photo1);
        
        
        let photo2 = Photo(name: "photo2",
                           date: "2333-20-10",
                           image: UIImage(named: "download1")!,
                           tag: "some")
                photoArray.append(photo2);
        
        
        let photo3 = Photo(name: "photo3",
                           date: "2044-20-10",
                           image: UIImage(named: "download3")!,
                           tag: "some2")
        photoArray.append(photo3);
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // count of rows
        return photoArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let photo = photoArray[indexPath.row]
        cell.textLabel?.text = photo.name + " "  + photo.tag + " " + photo.date
   
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//
//         let photo = photoArray[indexPath.row]
//
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let PhotoViewController = storyBoard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
//        
//        self.navigationController?.pushViewController(PhotoViewController, animated: true)
//        
//
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail"){
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! PhotoViewController
                destinationController.photo = photoArray[indexPath.row]
                
               
            }
        }
    }
 


}
