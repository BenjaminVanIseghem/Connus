//
//  FirstViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 26/04/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit
import Firebase

class SwipeViewController: UIViewController {

    var divisor: CGFloat!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = (view.frame.width / 2) / 0.61
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        //Scale value which is determined by the distance from the center
        let scale = min(80 / abs(xFromCenter), 1)
        
        //Center of the card is always where the finger is
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        //Transform card according to distance from center x
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        
        //Check distance from center
        //Show correct image with color and alpha values
        //Rotate image
        if xFromCenter > 0 {
            if let thumbsUpImage = UIImage(named: "thumbs_up") {
                let tintableImage = thumbsUpImage.withRenderingMode(.alwaysTemplate)
                self.thumbImageView.image = tintableImage
            }
            self.thumbImageView.tintColor = UIColor.green
        } else {
            if let thumbsDownImage = UIImage(named: "thumbs_down") {
                let tintableImage = thumbsDownImage.withRenderingMode(.alwaysTemplate)
                self.thumbImageView.image = tintableImage
            }
            self.thumbImageView.tintColor = UIColor.red
        }
        
        self.thumbImageView.alpha = abs(xFromCenter) / view.center.x
        
        //End state
        //Like or dislike
        if sender.state == UIGestureRecognizer.State.ended {
            if card.center.x < 75 {
                //Move to left => "dislike"
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                swipeDislike()
                return
            } else if card.center.x > (view.frame.width - 75){
                //Move to right => "like"
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                swipeLike()
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.view.center
            })
            self.thumbImageView.alpha = 0
            card.transform = CGAffineTransform.identity
        }
    }
    
    func loadCards() {
        //Load cards to show
    }
    
    func swipeLike() {
        //Logic for like
    }
    
    func swipeDislike() {
        //Logic for dislike
    }
}

