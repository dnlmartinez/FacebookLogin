//
//  ViewController.swift
//  FacebookLoginSwift
//
//  Created by daniel martinez gonzalez on 13/9/16.
//  Copyright © 2016 daniel martinez gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController , FBSDKLoginButtonDelegate
{
    
    let loginView : FBSDKLoginButton = FBSDKLoginButton()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dispatch_async(dispatch_get_main_queue())
        {
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            let screenWidth = screenSize.width
            
            if screenWidth > 410
            {
                self.loginView.frame = CGRectMake(38 , self.view.frame.height - 140 , self.view.frame.width - 76 , 44)
            }
            else
            {
                self.loginView.frame = CGRectMake(34 , self.view.frame.height - 140 , self.view.frame.width - 68 , 44)
            }
            
            self.view.addSubview(self.loginView)
            self.loginView.readPermissions = ["public_profile", "email", "user_friends"]
            self.loginView.delegate = self
        }

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: FACEBOOK DELEGATE
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if ((error) != nil)
        {
            
        }
        else if result.isCancelled
        {
            
        }
        else
        {
            if result.grantedPermissions.contains("email")
            {
                dispatch_async(dispatch_get_main_queue())
                {
                    self.loginView.hidden = true
                    self.returnUserData()
                }
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        FBSDKAccessToken.currentAccessToken()
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                dispatch_async(dispatch_get_main_queue())
                {
                    self.loginView.hidden = false
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue())
                {
                    self.loginView.hidden = true
                    let FBToken  = FBSDKAccessToken.currentAccessToken().tokenString as String
                }
            }
        })
    }

    

}

