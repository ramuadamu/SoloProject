//
//  WatchListCell.swift
//  SoloProject
//
//  Created by Ramu on 3/8/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit

class WatchListCell: UITableViewCell {

    @IBOutlet weak var watchListImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
