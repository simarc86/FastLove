//
//  FriendTableViewCell.swift
//  FastLove
//
//  Created by Marc Tamarit Romero on 25/11/17.
//  Copyright © 2017 Marc Tamarit. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var friendImage: UIImageView!

    func setImageWith(urlImage:URL){
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: urlImage)
            DispatchQueue.main.async {
                self.friendImage.image = UIImage(data: data!)}
        }
    }
}
