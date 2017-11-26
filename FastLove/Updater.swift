//
//  Updater.swift
//  FastLove
//
//  Created by Marc Tamarit Romero on 25/11/17.
//  Copyright © 2017 Marc Tamarit. All rights reserved.
//

import UIKit

protocol FriendsUpdaterDelegate {
    func friendsUpdaterResponse(friendsList: NSArray)
}

class Updater: NSObject, FriendsFBDelegate, UserDataDelegate {

    var friendsUpdaterDelegate:FriendsUpdaterDelegate?
    
    func responseFriends(friendsList:NSArray){        
        friendsUpdaterDelegate?.friendsUpdaterResponse(friendsList: friendsList)
    }
    
    func responseUserData(dictionary:NSDictionary){
        Manager.sharedInstance.user.updateWith(dictionary: dictionary)
        Manager.sharedInstance.user.saveInFirebase()
    }

}
