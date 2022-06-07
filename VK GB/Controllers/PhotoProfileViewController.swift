//
//  PhotoProfileViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 28.05.2022.
//

import UIKit

class PhotoProfileViewController: UIViewController {
    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var photo = [Photo]()
    var idxSelectPhoto = 0
    var propertyAnimate = UIViewPropertyAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if photo.count > 0 {
            imagePhoto.image = UIImage(systemName: photo[idxSelectPhoto].id)
        }
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(viewPaned(_:)))
        containerView.addGestureRecognizer(panGestureRecognizer)
        /*
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handlerSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handlerSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        */
    }
    
    @objc func viewPaned(_ recognizer: UIPanGestureRecognizer) {
        let xSwipe = recognizer.translation(in: view).x
        let wasIdxSelectPhoto = idxSelectPhoto
            
        switch recognizer.state{
        case .began:
            let maxForShift = xSwipe < 0 ? CGFloat(-200) : CGFloat(200)
            propertyAnimate = UIViewPropertyAnimator(duration: 2, curve: .easeInOut, animations: {
                self.containerView.transform = CGAffineTransform(translationX: maxForShift, y: 0)
            })

            propertyAnimate.addCompletion { position in
                self.containerView.transform = .identity
                switch position {
                case .end:
                    self.changeIdxNextPhoto(xSwipe: xSwipe)
                    if wasIdxSelectPhoto != self.idxSelectPhoto {
                        self.imagePhoto.image = UIImage(systemName: self.photo[self.idxSelectPhoto].id)
                    }
                case .start:
                    print("Start")
                case .current:
                    print("Current")
                @unknown default:
                    print("error")
                    break
                }
            }
        case .changed:
            let percent = abs(recognizer.translation(in: view).x / 200)
            propertyAnimate.fractionComplete = min(1, max(0, percent))
        case .ended:
            if propertyAnimate.fractionComplete > 0.5 {
                
                propertyAnimate.continueAnimation(withTimingParameters: nil, durationFactor: 0.1)
            } else {
                propertyAnimate.isReversed = true
                propertyAnimate.continueAnimation(withTimingParameters: nil, durationFactor: 0.1)
            }
        default:
            break
        }
    }
    
    private func changeIdxNextPhoto(xSwipe: CGFloat){
        let countPhoto = photo.count
        
        if xSwipe > CGFloat(0) {
            if countPhoto - 1 > self.idxSelectPhoto {
                self.idxSelectPhoto += 1
            }
        } else {
            if self.idxSelectPhoto > 0 {
                self.idxSelectPhoto -= 1
            }
        }
    }
    
    /*
    @objc func handlerSwipe(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            let countPhoto = photo.count
            let wasIdxSelectPhoto = idxSelectPhoto
            var optionAnimation: UIView.AnimationOptions = .transitionCurlUp
            
            switch swipeGesture.direction {
            case .right:
                if countPhoto - 1 > idxSelectPhoto {
                    idxSelectPhoto += 1
                    optionAnimation = .transitionFlipFromRight
                }
            case .left:
                if idxSelectPhoto > 0 {
                    idxSelectPhoto -= 1
                    optionAnimation = .transitionFlipFromLeft
                }
            default:
                break
            }
            if wasIdxSelectPhoto != idxSelectPhoto {
                UIView.transition(with: imagePhoto, duration: 1, options: optionAnimation) {
                    self.imagePhoto.image = UIImage(systemName: self.photo[self.idxSelectPhoto].id)
                }
            }
        }
    }
    */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
