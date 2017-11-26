//
//  FacebookManager.swift
//  FastLove
//
//  Created by Marc Tamarit Romero on 25/11/17.
//  Copyright © 2017 Marc Tamarit. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

protocol LoginFBDelegate{
    func responseLogin(logged:Bool)
}

//Este delegate lo implementara el Updater, lo asocia el Manager en el init
protocol FriendsFBDelegate{
    func responseFriends(friendsList:NSArray)
}

protocol UserDataDelegate{
    func responseUserData(dictionary:NSDictionary)
}
class FacebookManager: NSObject, FBSDKLoginButtonDelegate {
    
    var logged = false
    
    //Delegates
    var loginFBDelegate: LoginFBDelegate?
    var friendsFBDelegate: FriendsFBDelegate?
    var userDataDelegate: UserDataDelegate?

    
    //MARK: - Fetch Information
    func fetchLogged(){
        setStatus(logged:(FBSDKAccessToken.current() != nil))
    }
    
    func fetchUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
            }
            else
            {
                let resultdict = result as! NSDictionary
                self.userDataDelegate?.responseUserData(dictionary: resultdict)
            }
        })
    }
    
    func fetchFriends(){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me/friends?limit=5000", parameters: nil)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in

            let resultdict = result as! NSDictionary
            let friends = resultdict.object(forKey: "data") as! NSArray
            self.friendsFBDelegate?.responseFriends(friendsList: friends)

            
        })
    }
    
    // MARK:- LoginButtonDelegate
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                setStatus(logged: true)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        setStatus(logged: false)
    }
    
    
    
    //MARK: - Properties
    
    func setStatus(logged: Bool){
        self.logged = logged
        loginFBDelegate?.responseLogin(logged: self.logged)
    }
}
