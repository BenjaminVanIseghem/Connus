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
    
    //Buttons
    var blueNextBtn : UIButton?
    var selectProfilePictureBtn: UIButton?
    
    var lightblueView : UIView?
    var whiteView : UIView?
    
    var firstSection : FirstSectionView?
    var profNameView : ProfileNameAndImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init views
        self.initViews()
        self.initFirstSectionButtons()
        //Whe typing, this function dismisses keyboard when tapped elsewhere
        self.hideKeyboardWhenTappedAround()
        
//        DispatchQueue.global(qos: .userInitiated).async {
//            sleep(4)
//            // Bounce back to the main thread to update the UI
//            DispatchQueue.main.async {
//            }
//        }
        
        
    }
    
    private func initViews() {
        //Load views from xib files
        firstSection = firstSectionView.instantiateFromNib(viewType: FirstSectionView.self)
        profNameView = profileNameAndLocationView.instantiateFromNib(viewType: ProfileNameAndImageView.self)
        
        //Add to superview
        self.profileNameAndLocationView.addSubview(profNameView!)
        self.profileNameAndLocationView.makeInvisible() //This one should be invisible and animate to visible on next click
        self.firstSectionView.addSubview(firstSection!)
        
        //Check view height, if larger than iphone 6 -> init is slightly bigger
        if self.view.frame.height > 667 {
            //Set correct view positions
            let x = CGFloat(integerLiteral: 0)
            var height = self.view.frame.height * 0.3358
            var y = self.view.frame.height - height
            let width = self.view.frame.width
            //Set rect to use as view frame
            var rect = CGRect(x: x, y: y, width: width, height: height)
            //init lightblueView
            self.lightblueView = UIView(frame: rect)
            
            //override values to use for whiteView
            height = self.view.frame.height * 0.20
            y = self.view.frame.height - height
            //Set rect to use as whiteView frame
            rect = CGRect(x: x, y: y, width: width, height: height)
            //init whiteView
            self.whiteView = UIView(frame: rect)
        } else {
            //Set correct view positions
            let x = CGFloat(integerLiteral: 0)
            var height = self.view.frame.height * 0.30
            var y = self.view.frame.height - height
            let width = self.view.frame.width
            //Set rect to use as lightblueView frame
            var rect = CGRect(x: x, y: y, width: width, height: height)
            //init lightblueView
            self.lightblueView = UIView(frame: rect)
            
            //override values to use for whiteView
            height = self.view.frame.height * 0.16
            y = self.view.frame.height - height
            //Set rect to use as whiteView frame
            rect = CGRect(x: x, y: y, width: width, height: height)
            //init whiteView
            self.whiteView = UIView(frame: rect)
        }
        
        //set the backgroundcolors
        self.lightblueView?.backgroundColor = lightBlueColor
        self.whiteView?.backgroundColor = whiteColor
        
        //Set views with rounded top corners
        self.lightblueView?.roundTopCorners()
        self.whiteView?.roundTopCorners()
        
        //Add views to superview
        self.view.addSubview(lightblueView!)
        self.view.addSubview(whiteView!)
        
        self.initSecondSection()
        self.initThirdSection()
    }
    
    private func initFirstSectionButtons() {
        //Make sure the firstSectionView has the appropriate dimensions before initializing the buttons according to this size
        let frame = CGRect(x: firstSectionView.frame.minX, y: firstSectionView.frame.minY, width: self.view.frame.width - 80, height: firstSectionView.frame.height)
        self.firstSectionView.frame = frame
        
        //Init system type button
        let button = UIButton(type: .system)
        //Calculate position for button
        let viewFrame = self.firstSectionView.frame
        let width = 80
        let height = 30
        let x = Int(viewFrame.width) - width
        let y = Int(viewFrame.height) - height
        //Make rect for frame
        let rect = CGRect(x: x, y: y, width: width, height: height)
        //Set button frame
        button.frame = rect
        //Color
        button.backgroundColor = lightBlueColor
        button.setTitleColor(whiteColor, for: .normal)
        //Font
        button.titleLabel?.font = UIFont(name: "CocoGothic-Bold", size: 14)
        //Text
        button.setTitle("Next", for: .normal)
        //Rounded corners
        button.layer.cornerRadius = 15
        //Make clickable
        button.addTarget(self, action: #selector(blueNextBtnPressed), for: .touchUpInside)
        //Save button onto whiteNextBtn
        self.blueNextBtn = button
        
        self.firstSectionView.addSubview(button)
        
        //Profile picture select button
        //Init system type button
        let pButton = UIButton(type: .system)
        //Calculate position for button
        let w = 140
        let h = 30
        let newX = 0
        let newY = (self.firstSection?.infoLbl.frame.height)! + 8
        //Make rect for frame
        let r = CGRect(x: newX, y: Int(newY), width: w, height: h)
        //Set button frame
        pButton.frame = r
        //Color
        pButton.setTitleColor(lightBlueColor, for: .normal)
        //Font
        pButton.titleLabel?.font = UIFont(name: "CocoGothic", size: 14)
        //Text
        pButton.setTitle("select profile picture", for: .normal)
        //Make clickable
        pButton.addTarget(self, action: #selector(selectProfilePictureBtnPressed), for: .touchUpInside)
        //Save button onto whiteNextBtn
        self.selectProfilePictureBtn = pButton
        
        self.firstSectionView.addSubview(pButton)
    }
    
    private func initSecondSection(){
        
    }
    
    private func initThirdSection(){
        
    }
    //------------------------ Animations ----------------------------------
    
    private func animateToSecondView() {
        //Calculate new position for profileNameAndLocationView
        let midX = self.profileNameAndLocationView.frame.midX
        let midY = 120 + (self.profileNameAndLocationView.frame.height / 2)
        let newPos = CGPoint(x: midX, y: midY)
        //Begin animation
        UIView.animate(withDuration: 0.5, animations: {
            self.profileNameAndLocationView.center = newPos
            self.profileNameAndLocationView.makeVisible()
            self.firstSectionView.makeInvisible()
        })
    }
    
    //------------------------ Objc functions --------------------------------
    @objc private func blueNextBtnPressed() {
        animateToSecondView()
    }
    
    @objc private func selectProfilePictureBtnPressed() {
        print("Select profile picture btn pressed!")
    }
}
