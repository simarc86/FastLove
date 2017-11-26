//
//  Manager.swift
//  FastLove
//
//  Created by Marc Tamarit Romero on 25/11/17.
//  Copyright © 2017 Marc Tamarit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Manager {
    static let sharedInstance = Manager()
    

    let facebookManager = FacebookManager() //Manager para todo lo relacionado con FB
    var user = User()                       //Usuario de la app
    let updater = Updater()
    var ref: DatabaseReference!

    
    private init() {
        facebookManager.friendsFBDelegate = updater
        facebookManager.userDataDelegate = updater
        updater.friendsUpdaterDelegate = user
        
        FirebaseApp.configure()
        ref = Database.database().reference()

    }
    

}
