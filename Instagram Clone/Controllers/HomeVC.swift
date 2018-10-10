//
//  HomeVC.swift
//  Instagram Clone
//
//  Created by Matthew on 10/1/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts: [PFObject] = []
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure tableView settings
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 500
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeVC.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
    }
    
    // get image data from Parse database
    func fetchData() {
        let post = Post()
        
        // get the current user and assign it to "author" field. "author" field is now of Pointer type
        post.author = PFUser.current()!
        
        // construct PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (postsFromBackground, error) in
            if let postsFromBackground = postsFromBackground {
                self.posts = postsFromBackground
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print(error?.localizedDescription as Any)
            }
        })
        
    }
    
    // function to logout
    @IBAction func onLogOut(_ sender: Any) {
        // Post a notification when user taps logout button
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        
        // clears current user cache and takes user back to LoginVC
        // PFUser.current() will now be nil
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
    
    // tableview protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    // tableview protocol
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        // TODO: set cell properties, link image and caption field
        //let user = posts[indexPath.row]["author"] as! PFUser
        if(posts.isEmpty) {
            cell.feedCaptionLabel.text = "Placeholder text"
            cell.feedImageView.image = UIImage(named: "image_placeholder")
        } else {
            let cellDict = posts[indexPath.row]
            cell.feedCaptionLabel.text = cellDict["caption"] as? String
            cell.feedImageView.file = cellDict["media"] as? PFFile
            cell.feedImageView.loadInBackground()
        }
            
        return cell
    }
    
    func UTCToLocal(UTCDateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss a" //Input Format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let UTCDate = dateFormatter.date(from: UTCDateString)
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss a" // Output Format
        dateFormatter.timeZone = TimeZone.current
        let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
        return UTCToCurrentFormat
    }
    
    // set properties in DetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            //_ = sender as! UIButton
            if let indexPath = tableView.indexPathForSelectedRow {
                print("SUCCESS")
                // set caption label
                let cellDict = posts[indexPath.row]
                let detailViewController = segue.destination as! DetailVC
                detailViewController.detailCaptionLabel.text = cellDict["caption"] as? String
                
                // set time stamp label
                let date = cellDict.createdAt
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss a"
                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                let stringDate = dateFormatter.string(from: date!)
                let currentDate = self.UTCToLocal(UTCDateString: stringDate)
                detailViewController.detailTimeStampLabel.text = currentDate
                
            }
        }
    }

}
