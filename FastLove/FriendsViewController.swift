//
//  FriendsViewController.swift
//  FastLove
//
//  Created by Marc Tamarit Romero on 25/11/17.
//  Copyright © 2017 Marc Tamarit. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UserFriendsUpdateDelegate, UITableViewDelegate, UITableViewDataSource {

    let cellReuseIdentifier = "friendsCell"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    
    let facebookManager = Manager.sharedInstance.facebookManager
    var friendsList = Manager.sharedInstance.user.friends

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        Manager.sharedInstance.user.userFriendsUpdateDelegate = self
    }
    
    func userFriendsUpdated() {
        friendsList = Manager.sharedInstance.user.friends
        tableView.reloadData()
    }
    
    //MARK: - TableViewDelegate
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        let cell:FriendTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! FriendTableViewCell!
        
        let friend = friendsList[indexPath.row]
        cell.nameLbl?.text = friend.name
        cell.setImageWith(urlImage: friend.imageURL!)
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        let friend = friendsList[indexPath.row]
        friend.selected = !friend.selected
    }
    
    @IBAction func actionBtnTapped(_ sender: Any) {
        Manager.sharedInstance.user.sendFriendsSelecteds()
    }
}
