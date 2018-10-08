//
//  HomeCell.swift
//  Instagram Clone
//
//  Created by Matthew on 10/2/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeCell: UITableViewCell {

    @IBOutlet weak var feedImageView: PFImageView!
    @IBOutlet weak var feedCaptionLabel: UILabel!
    
    /*
    var instagramPost: PFObject! {
        didSet {
            self.feedImageView.file = instagramPost["media"] as? PFFile
            self.feedCaptionLabel.text = instagramPost["caption"] as? String
            self.feedImageView.loadInBackground()
        }
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
