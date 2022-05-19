//
//  ProfileCollectionViewCell.swift
//  VK GB
//
//  Created by Роман Вертячих on 11.05.2022.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionPhoto: UILabel!
    
    @IBOutlet var likeControl: LikeControl!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlerTap(_:)))
        tap.numberOfTapsRequired = 2
        containerView.addGestureRecognizer(tap)
        
    }

    @objc func handlerTap(_ :UITapGestureRecognizer) {
        likeControl.isLiked.toggle()
        if likeControl.isLiked {
            likeControl.likeImage.image = UIImage(systemName: "suit.heart.fill")
        } else {
            likeControl.likeImage.image = nil
        }
    }
    
}
