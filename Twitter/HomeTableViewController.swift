//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Jacob Ortiz on 9/21/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweets_array = [NSDictionary]()
    var number_of_tweets: Int!
    
    let refresh_control = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        refresh_control.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = refresh_control
    }
    
    @objc func loadTweets() {
        number_of_tweets = 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let parameters = ["count": number_of_tweets]

        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: parameters, success: { (tweets: [NSDictionary]) in
            self.tweets_array.removeAll()
            for tweet in tweets {
                self.tweets_array.append(tweet)
            }
            self.tableView.reloadData()
            self.refresh_control.endRefreshing()
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
    }
    
    func loadMoreTweets() {
        number_of_tweets += 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let parameters = ["count": number_of_tweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: parameters, success: { (tweets: [NSDictionary]) in
            self.tweets_array.removeAll()
            for tweet in tweets {
                self.tweets_array.append(tweet)
            }
            self.tableView.reloadData()
            self.refresh_control.endRefreshing()
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "user_logged_in")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweet_cell", for: indexPath) as! TweetTableViewCell
        
        let user = tweets_array[indexPath.row]["user"] as! NSDictionary
        cell.username_label.text = user["name"] as? String
        cell.tweet_content_label.text = tweets_array[indexPath.row]["text"] as? String
        
        let image_url = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: image_url!)
        
        if let image_data = data {
            cell.profile_image_view.image = UIImage(data: image_data)
        }
        
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets_array.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweets_array.count {
            loadMoreTweets()
        }
    }

}
