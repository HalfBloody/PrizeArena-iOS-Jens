//
//  ViewController.swift
//  PrizeArena
//
//  Created by Jens Disselhoff on 04/12/15.
//  Copyright © 2015 oll. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            print("has FB access token")
            let prizesViewControllerView = self.storyboard?.instantiateViewControllerWithIdentifier("PrizesViewController") as! PrizesViewController
            print("instanciated")
            self.navigationController!.pushViewController(prizesViewControllerView
                , animated: true)
            print("shows prizes view controller view")
//        self.performSegueWithIdentifier("showPrizes", sender: self)

        }
        let login_button = FBSDKLoginButton()
        login_button.center = self.view.center
        login_button.readPermissions = ["public_profile", "email", "user_friends"]
        login_button.delegate = self
        self.view.addSubview(login_button)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        if ((error) != nil)
        {
            print("there is an error")
            print(error)
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
            print("canceled")
        }
        else {
            print("performing show prizes segue")
            let prizesViewControllerView = self.storyboard?.instantiateViewControllerWithIdentifier("PrizesViewController") as! PrizesViewController
            print("instanciated")
            self.navigationController!.pushViewController(prizesViewControllerView
                , animated: true)
            print("shows prizes view controller view")
//            print("show it now!!!!!!!")
//            self.performSegueWithIdentifier("showPrizes", sender: self)
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
//            if result.grantedPermissions.contains("email")
//            {
//
//            }
        }
    }
    
//    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
//        let prizesViewControllerView = self.storyboard?.instantiateViewControllerWithIdentifier("PrizesViewController") as! PrizesViewController
//        print("instanciated")
//        self.navigationController!.pushViewController(prizesViewControllerView
//            , animated: true)
//        return true
//    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

