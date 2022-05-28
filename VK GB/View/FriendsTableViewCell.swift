//
//  friendsTableViewCell.swift
//  VK GB
//
//  Created by Роман Вертячих on 03.05.2022.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var alias: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var containerAvatar: AvatarFriendUIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
