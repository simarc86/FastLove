//
//  Friend.swift
//  FastLove
//
//  Created by Marc Tamarit Romero on 25/11/17.
//  Copyright © 2017 Marc Tamarit. All rights reserved.
//

import UIKit

class Friend: NSObject {

    var idFriend = ""
    var name = ""
    var imageURL: URL?
    var image = UIImage()
    var selected = false
    
    static func initWith(dic: NSDictionary) -> Friend{
        let friend = Friend()
        friend.idFriend =  dic.object(forKey: "id") as! String
        friend.name =  dic.object(forKey: "name") as! String
        friend.imageURL = getImageURL(info: dic.object(forKey: "picture") as! NSDictionary)
        
        return friend
    }
    
    static func getImageURL(info:NSDictionary) -> URL{
        let data = info["data"] as! NSDictionary
        let url = data.object(forKey:"url") as! String
        return NSURL(string:url)! as URL
    }
}
