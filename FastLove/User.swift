//
//  User.swift
//  FastLove
//
//  Created by Marc Tamarit Romero on 25/11/17.
//  Copyright © 2017 Marc Tamarit. All rights reserved.
//

import UIKit

protocol UserFriendsUpdateDelegate {
    func userFriendsUpdated()
}

class User: NSObject, FriendsUpdaterDelegate {
    var name = ""
    var userId = ""
    var friends = [Friend]()
    var userFriendsUpdateDelegate:UserFriendsUpdateDelegate?
    
    
    func updateWith(dictionary:NSDictionary){
        name = dictionary["name"]! as! String
        userId = dictionary["id"]! as! String
    }
    
    func updateFriends(friendsList: NSArray){
        cleanFriends()
        
        for friendDic in friendsList{
            let friend = Friend.initWith(dic:friendDic as! NSDictionary)
            friends.append(friend)
        }
        
        userFriendsUpdateDelegate?.userFriendsUpdated()
    }
    
    
    func cleanFriends(){
        friends.removeAll()
    }
    
    func saveInFirebase(){
        Manager.sharedInstance.ref.setValue(userId)
    }
    
    func sendFriendsSelecteds(){
//        let selecteds = friends.filter { $0.selected.filter == true }
        let selecteds = friends.filter{ $0.selected == true }
        let ids = selecteds.map { $0.idFriend }
        Manager.sharedInstance.ref.child("\(userId)/selecteds").setValue(ids)
    }
    
    //MARK: -FriendsUpdaterDelegate
    func friendsUpdaterResponse(friendsList: NSArray){
        updateFriends(friendsList: friendsList)
    }
}
