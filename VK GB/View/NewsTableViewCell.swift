//
//  NewsTableViewCell.swift
//  VK GB
//
//  Created by Роман Вертячих on 24.05.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    
    @IBOutlet var likeControl: LikeControl!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var likeCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlerTap(_:)))
        tap.numberOfTapsRequired = 1
        containerView.addGestureRecognizer(tap)
    }

    @objc func handlerTap(_ :UITapGestureRecognizer) {
        likeControl.isLiked.toggle()
        if likeControl.isLiked {
            likeControl.likeImage.image = UIImage(systemName: "suit.heart.fill")
            likeCount.text = String(Int(likeCount.text ?? "0")! + 1)
            
        } else {
            likeControl.likeImage.image = UIImage(systemName: "suit.heart")
            likeCount.text = String(Int(likeCount.text ?? "0")! - 1)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
