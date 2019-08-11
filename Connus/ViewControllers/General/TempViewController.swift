//
//  TempViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 07/08/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {
    
    //UI Views
    @IBOutlet weak var firstSectionView: UIView!
    @IBOutlet weak var profileNameAndLocationView: UIView!
    
    var lightblueView : UIView?
    var whiteView : UIView?
    
    var firstSection : FirstSectionView?
    var profNameView : ProfileNameAndImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.view.frame.height > 667 {
            //Set correct view positions
            let x = CGFloat(integerLiteral: 0)
            var height = self.view.frame.height * 0.3358
            var y = self.view.frame.height - height
            let width = self.view.frame.width
            var rect = CGRect(x: x, y: y, width: width, height: height)
            self.lightblueView = UIView(frame: rect)

            height = self.view.frame.height * 0.20
            y = self.view.frame.height - height
            rect = CGRect(x: x, y: y, width: width, height: height)
            self.whiteView = UIView(frame: rect)
        } else {
            //Set correct view positions
            let x = CGFloat(integerLiteral: 0)
            var height = self.view.frame.height * 0.30
            var y = self.view.frame.height - height
            let width = self.view.frame.width
            var rect = CGRect(x: x, y: y, width: width, height: height)
            self.lightblueView = UIView(frame: rect)

            height = self.view.frame.height * 0.16
            y = self.view.frame.height - height
            rect = CGRect(x: x, y: y, width: width, height: height)
            self.whiteView = UIView(frame: rect)
        }
        
        self.lightblueView?.backgroundColor = lightBlueColor
        self.whiteView?.backgroundColor = whiteColor
        
        //Set views with rounded top corners
        self.lightblueView?.roundTopCorners()
        self.whiteView?.roundTopCorners()
        
        self.view.addSubview(lightblueView!)
        self.view.addSubview(whiteView!)
        
        
//        DispatchQueue.global(qos: .userInitiated).async {
//            sleep(4)
//            // Bounce back to the main thread to update the UI
//            DispatchQueue.main.async {
//            }
//        }
        firstSection = firstSectionView.instantiateFromNib(viewType: FirstSectionView.self)
        profNameView = profileNameAndLocationView.instantiateFromNib(viewType: ProfileNameAndImageView.self)
        self.profileNameAndLocationView.translatesAutoresizingMaskIntoConstraints = false
        self.firstSectionView.translatesAutoresizingMaskIntoConstraints = false
        self.profileNameAndLocationView.addSubview(profNameView!)
        self.profileNameAndLocationView.makeInvisible()
        self.firstSectionView.addSubview(firstSection!)
        self.hideKeyboardWhenTappedAround()
    }
}
