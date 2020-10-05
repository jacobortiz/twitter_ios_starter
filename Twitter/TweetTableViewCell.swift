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
    @IBOutlet weak var retweet_button: UIButton!
    @IBOutlet weak var fav_button: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        if(favorited) {
            fav_button.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            fav_button.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    @IBAction func onLikeTweet(_ sender: Any) {
        let to_be_favorited = !favorited
        if(to_be_favorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not work: \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not work: \(Error)")
            })
        }
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Could not retweet: \(Error)")
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        if(isRetweeted) {
            retweet_button.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweet_button.isEnabled = false
        } else {
            retweet_button.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweet_button.isEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
