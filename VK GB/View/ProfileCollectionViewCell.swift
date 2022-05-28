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
    @IBOutlet weak var likeCount: UILabel!
    
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlerTap(_:)))
        tap.numberOfTapsRequired = 2
        containerView.addGestureRecognizer(tap)
        
    }

    @objc func handlerTap(_ :UITapGestureRecognizer) {
        likeControl.isLiked.toggle()
        if likeControl.isLiked {
            UIView.transition(with: likeControl.likeImage, duration: 1, options: .transitionFlipFromRight) {
                self.likeControl.likeImage.image = UIImage(systemName: "suit.heart.fill")
            }
            UIView.transition(with: likeCount, duration: 1, options: .transitionFlipFromBottom) {
                self.likeCount.text = String(Int(self.likeCount.text ?? "0")! + 1)
            }
        } else {
            UIView.transition(with: likeControl.likeImage, duration: 1, options: .transitionFlipFromRight) {
                self.likeControl.likeImage.image = UIImage(systemName: "suit.heart")
            }
            UIView.transition(with: likeCount, duration: 1, options: .transitionFlipFromBottom) {
                self.likeCount.text = String(Int(self.likeCount.text ?? "0")! - 1)
            }
        }
    }
}
