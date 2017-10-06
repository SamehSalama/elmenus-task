//
//  ItemTableViewCell.swift
//  elmenus Task
//
//  Created by Sameh Salama on 10/5/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemLikeButton: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.itemLikeButton.layer.shadowColor = UIColor.black.cgColor
        self.itemLikeButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.itemLikeButton.layer.shadowRadius = 0.1
        self.itemLikeButton.layer.shadowOpacity = 0.3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
