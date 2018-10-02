//
//  HomeCell.swift
//  Instagram Clone
//
//  Created by Matthew on 10/2/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedCaptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
