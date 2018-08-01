//
//  PhotoCell.swift
//  my_testProj
//
//  Created by mac-130-71 on 8/1/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

  
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var laberDate: UILabel!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
