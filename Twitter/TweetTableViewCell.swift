//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Jacob Ortiz on 9/24/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profile_image_view: UIImageView!
    @IBOutlet weak var username_label: UILabel!
    @IBOutlet weak var tweet_content_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
