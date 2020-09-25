//
//  LoginViewController.swift
//  Twitter
//
//  Created by Jacob Ortiz on 9/21/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "user_logged_in") == true {
            self.performSegue(withIdentifier: "login_to_home", sender: self)
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let url = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: url, success: {
            UserDefaults.standard.set(true, forKey: "user_logged_in")
            // perform segue
            self.performSegue(withIdentifier: "login_to_home", sender: self)
        }, failure: { (Error) in
            print("could not log in")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
