//
//  CustomCell.swift
//  BetSquad
//
//  Created by Viktor on 25/04/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
