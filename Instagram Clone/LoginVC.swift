//
//  LoginVC.swift
//  Instagram Clone
//
//  Created by Matthew on 9/30/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set rounded corners for login fields
        usernameField.layer.cornerRadius = 5
        usernameField.clipsToBounds = true
        passwordField.layer.cornerRadius = 5
        passwordField.clipsToBounds = true
        signInButton.layer.cornerRadius = 5
        signInButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("Logged in.")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground {(success: Bool, error: Error?) in
            if success {
                print("User registered successfully.")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription as Any)
                if error?._code == 202 {
                    print("Username is taken. ")
                }
            }
        }
        
    }
    
}
