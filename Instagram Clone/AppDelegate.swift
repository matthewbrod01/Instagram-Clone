//
//  AppDelegate.swift
//  Instagram Clone
//
//  Created by Matthew on 9/30/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Parse (Link with Heroku)
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Instagram-Clone"
                configuration.clientKey = "save0785ink57fact"
                configuration.server = "https://stark-sea-52283.herokuapp.com/parse"
            })
        )
        
        // Create a notification observer for Logging Out
        NotificationCenter.default.addObserver(forName: Notification.Name("didLogout"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Logout notification received")
            // TODO: Logout the User
            // TODO: Load and show the login view controller
        }
        
        
        /* CODE BLOCK BELOW IS COMMENTED OUT TEMPORARILY.
           UNSURE HOW TO PORTRAY BOTH TAB BAR CONTROLLER AND NAV CONTROLLER
           ON APP RESTARTS.
         
        // Check if user is logged in for persisting user session
        if PFUser.current() != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // view controller currently being set in Storyboard as default will be overridden
            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            
            // persisting user session only shows a white screen
            // might be because HomeVC has a navigation controller
            // this shows navigation controller on top of HomeVC
            let navigationVC = UINavigationController(rootViewController: homeVC)
            self.window?.rootViewController = navigationVC
            
        }
 
        */
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

