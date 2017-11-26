//
//  LoginViewController.swift
//  FastLove
//
//  Created by Marc Tamarit Romero on 25/11/17.
//  Copyright © 2017 Marc Tamarit. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: UIViewController, LoginFBDelegate{

    let facebookManager = Manager.sharedInstance.facebookManager

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delcara delegate
        facebookManager.loginFBDelegate = self
        
        //Obtiene el logged
        facebookManager.fetchLogged()
        
        //Prepara el boton de FB
        setUpFB()
    }

    func setUpFB(){
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = facebookManager
    }
    
    func checkLogged(){
        if(facebookManager.logged){
            facebookManager.fetchUserData()
            facebookManager.fetchFriends()
            goToFriendsVC()
        }
    }
    
    func goToFriendsVC(){
        performSegue(withIdentifier: "SegueLoginFriends", sender: nil)

    }
    
    func responseLogin(logged response:Bool){
        checkLogged()
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
