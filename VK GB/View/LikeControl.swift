//
//  LikeControl.swift
//  VK GB
//
//  Created by Роман Вертячих on 18.05.2022.
//

import UIKit

class LikeControl: UIControl {
    @IBOutlet var likeImage: UIImageView!
    var isLiked = false
    
    override func awakeFromNib() {
        likeImage.backgroundColor = .clear
        likeImage.tintColor = .blue
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
