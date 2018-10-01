//
//  HomeVC.swift
//  Instagram Clone
//
//  Created by Matthew on 10/1/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit
import Parse

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        // Post a notification when user taps logout button
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        
        // clears current user and takes user back to LoginVC
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                self.view.window?.rootViewController = loginViewController
            }
        })
    }


}
