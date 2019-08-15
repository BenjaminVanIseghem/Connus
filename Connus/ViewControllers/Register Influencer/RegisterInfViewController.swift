//
//  RegisterInfViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 29/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

struct Views {
    var first = "firstSectionView"
    var second = "lightblueView"
    var third = "whiteView"
}

class RegisterInfViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Connected UI elements
    @IBOutlet weak var firstSectionView: UIView!
    @IBOutlet weak var profileNameAndLocationView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    //UIViews
    var lightblueView : UIView?
    var whiteView : UIView?
    var interestsView : UIView?
    
    //Sections views
    var firstSection : FirstSectionView?
    var profNameView : ProfileNameAndImageView?
    var platformView : SecondSectionView?
    var genresView : ThirdSectionView?
    
    //Buttons
    var blueNextBtn : UIButton?
    var selectProfilePictureBtn: UIButton?
    var platformButtons : [UIButton]?
    var interestButtons : [UIButton]?
    
    //Extra variables
    var views = Views()
    var currentActiveSectionView : String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hideShadow()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navigation bar color
        self.navigationController?.navigationBar.barTintColor = darkBlueColor

        //Init views
        self.initViews()
        //When typing, this function dismisses keyboard when tapped elsewhere
        self.hideKeyboardWhenTappedAround()
        //Add swipe gesture recognizers
        self.addSwipeGestureRecognizers()
        //Set current active view
        self.currentActiveSectionView = views.first
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.view.frame.height > 667 {
            //Set image a bit lower than on the smaller screens
            self.logoImageView.center = CGPoint(x: self.logoImageView.frame.midX, y: self.logoImageView.frame.midY + 10)
        }
    }
    
    private func initViews() {
        //Load views from xib files
        firstSection = firstSectionView.instantiateFromNib(viewType: FirstSectionView.self)
        profNameView = profileNameAndLocationView.instantiateFromNib(viewType: ProfileNameAndImageView.self)
        
        //Add actions to the buttons of the view
        firstSection?.whiteNextBtn.addTarget(self, action: #selector(blueNextBtnPressed), for: .touchUpInside)
        firstSection?.selectProfilePictureBtn.addTarget(self, action: #selector(selectProfilePictureBtnPressed), for: .touchUpInside)
        
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
        
        //Make sure no resizing happens when shrinking or growing the views
        self.lightblueView?.autoresizesSubviews = false
        self.whiteView?.autoresizesSubviews = false
        
        self.initSecondSection()
        self.initThirdSection()
        
        //Add views to superview
        self.view.addSubview(lightblueView!)
        self.view.addSubview(whiteView!)
        
        //Add redirect to login button + label
        self.initLoginBtnAndLabel()
        
        
    }
    
    private func initSecondSection(){
        self.platformView = UIView().instantiateFromNib(viewType: SecondSectionView.self)
        //Add action to button from the SecondSectionView xib
        self.platformView!.nextBtn.addTarget(self, action: #selector(whiteNextBtnPressed), for: .touchUpInside)
        //Make invisible
        self.platformView?.makeInvisible()
        //Add to lightblueView
        self.lightblueView?.addSubview(self.platformView!)
        //Adjust position relative to superview
        let height = (self.lightblueView!.frame.width - 80) / 1.14 //1.14 is th aspect ratio of the platformview
        let r = CGRect(x: 40, y: 35, width: Int(self.lightblueView!.frame.width) - 80, height: Int(height))
        self.platformView?.frame = r
        
        //Set extra parameters for the platform buttons
        self.platformButtons = self.platformView?.platformBtnCollection
        for button in self.platformButtons! {
            button.addTarget(self, action: #selector(platformBtnPressed), for: .touchUpInside)
        }
    }
    
    private func initThirdSection(){
        self.genresView = UIView().instantiateFromNib(viewType: ThirdSectionView.self)
        //Add action to button from the ThirdSectionView xib
        self.genresView?.finishBtn.addTarget(self, action: #selector(finishBtnPressed), for: .touchUpInside)
        //Make invisible
        self.genresView?.makeInvisible()
        //Add to whiteView
        self.whiteView?.addSubview(self.genresView!)
        //Adjust position relative to superview
        let height = (self.whiteView!.frame.width - 80) / 1.03 //1.03 is th aspect ratio of the genresView
        let r = CGRect(x: 40, y: 35, width: Int(self.whiteView!.frame.width) - 80, height: Int(height))
        self.genresView?.frame = r
        
        //Set extra parameters for the genres of interest buttons
        self.interestButtons = self.genresView?.interestBtnCollection
        for button in self.interestButtons! {
            button.addTarget(self, action: #selector(interestBtnPressed), for: .touchUpInside)
        }
    }
    
    private func initLoginBtnAndLabel() {
        //Calculate frame for label
        let height = 20
        let width = 170
        let y = Int(self.view.frame.height) - (height + 20)
        
        let rect = CGRect(x: 40, y: y, width: width, height: height)
        //create label
        let label = UILabel(frame: rect)
        
        //Color
        label.font = UIFont.init(name: "CocoGothic", size: 14)
        //Font
        label.textColor = nearlyBlackColor
        //Text
        label.text = "Already have an account?"
        
        let btnHeight = 30
        let btnWidth = 42
        let x = Int(label.frame.maxX) + 5
        
        let r = CGRect(x: x, y: Int(label.frame.minY) - 5, width: btnWidth, height: btnHeight)
        //create button
        let button = UIButton(type: .system)
        button.frame = r
        
        //Color
        button.setTitleColor(lightBlueColor, for: .normal)
        //Font
        button.titleLabel?.font = UIFont(name: "CocoGothic", size: 14)
        //Text
        button.setTitle("Log in", for: .normal)
        //Add action to button
        button.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        
        //Add to superview
        self.view.addSubview(label)
        self.view.addSubview(button)
    }
    //------------------------ Animations ----------------------------------
    private func animateToFirstView(){
        //Check screen size, iphone 6,7,8 only have 667 points height.
        //Smaller screens need different positions
        if self.view.frame.height > 667 {
            let height = self.view.frame.height * 0.3358
            let y = self.view.frame.height - height
            //Calculate frame rect for growing lightblueView
            let rect = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
            //Begin animation
            UIView.animate(withDuration: 0.5, animations: {
                self.profileNameAndLocationView.makeInvisible()
                self.profileNameAndLocationView.transform = CGAffineTransform(translationX: 0, y: 80)
                self.platformView?.makeInvisible()
                self.lightblueView?.frame = rect
            }) { completed in
                UIView.animate(withDuration: 0.5, animations: {
                    self.firstSectionView.makeVisible()
                })
            }
        } else {
            let height = self.view.frame.height * 0.30
            let y = self.view.frame.height - height
            //Calculate frame rect for growing lightblueView
            let rect = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
            //Begin animation
            UIView.animate(withDuration: 0.5, animations: {
                self.profileNameAndLocationView.makeInvisible()
                self.profileNameAndLocationView.transform = CGAffineTransform(translationX: 0, y: 75)
                self.platformView?.makeInvisible()
                self.platformView?.transform = CGAffineTransform(translationX: 0, y: 10)
                self.lightblueView?.frame = rect
            }) { completed in
                UIView.animate(withDuration: 0.5, animations: {
                    self.firstSectionView.makeVisible()
                })
            }
        }
        
        //Set new current active view
        self.currentActiveSectionView = views.first
    }
    
    private func animateToSecondView() {
        //Check profile and save to profNameView
        guard self.firstSection!.profileNameTextField.text != "" else {
            //Warning popup
            self.notFilledInWarning()
            return
        }
        self.profNameView?.profileNameLbl.text = self.firstSection?.profileNameTextField.text
        
        //Check screen size, iphone 6,7,8 only have 667 points height.
        //Smaller screens need different positions
        if self.view.frame.height > 667 {
            //Calculate frame rect for growing lightblueView
            let rect = CGRect(x: 0, y: 250, width: self.view.frame.width, height: self.view.frame.height - 250)
            //Begin animation
            UIView.animate(withDuration: 0.5, animations: {
                self.profileNameAndLocationView.transform = CGAffineTransform(translationX: 0, y: -80)
                self.profileNameAndLocationView.makeVisible()
                self.firstSectionView.makeInvisible()
                self.lightblueView?.frame = rect
            }) { completed in
                UIView.animate(withDuration: 0.5, animations: {
                    self.platformView?.makeVisible()
                })
            }
        } else {
            //Calculate frame rect for growing lightblueView
            let rect = CGRect(x: 0, y: 230, width: self.view.frame.width, height: self.view.frame.height - 230)
            //Begin animation
            UIView.animate(withDuration: 0.5, animations: {
                self.profileNameAndLocationView.transform = CGAffineTransform(translationX: 0, y: -75)
                self.profileNameAndLocationView.makeVisible()
                self.firstSectionView.makeInvisible()
                self.platformView?.transform = CGAffineTransform(translationX: 0, y: -10)
                self.lightblueView?.frame = rect
            }) { completed in
                UIView.animate(withDuration: 0.5, animations: {
                    self.platformView?.makeVisible()
                })
            }
        }
        
        //Set new current active view
        self.currentActiveSectionView = views.second
    }
    
    private func animateToThirdView() {
        //Use function to check all button if there is one selected
        let btnColl = self.getSelecteddBtns(btnArr: self.platformButtons!)
        //If no buttons are selected, give a warning and skip
        if btnColl.isEmpty {
            self.platformWarning()
            return
        }
        //If one or more buttons was selected, proceed with animation
        //Variables
        var rect : CGRect
        var newY : Int
        
        //Check screen size, iphone 6,7,8 only have 667 points height.
        //Smaller screens need different positions
        if self.view.frame.height > 667 {
            newY = Int(self.lightblueView!.frame.minY) + 100
        } else {
            newY = Int(self.lightblueView!.frame.minY) + 60
        }
        rect = CGRect(x: 0, y: newY, width: Int(self.view.frame.width), height: Int(self.view.frame.height) - newY)
        
        //Begin animation
        UIView.animate(withDuration: 0.5, animations: {
            self.platformView?.makeInvisible()
            self.whiteView?.frame = rect
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.genresView?.makeVisible()
            })
        }
        
        //Set new current active view
        self.currentActiveSectionView = views.third
    }
    
    private func animateToSecondViewFromThirdView(){
        //Variables
        var rect : CGRect
        var height : Int
        var y : Int
        
        //Check screen size, iphone 6,7,8 only have 667 points height.
        //Smaller screens need different positions
        if self.view.frame.height > 667 {
            height = Int(self.view.frame.height * 0.20)
            y = Int(self.view.frame.height) - height
        } else {
            height = Int(self.view.frame.height * 0.16)
            y = Int(self.view.frame.height) - height
        }
        rect = CGRect(x: 0, y: y, width: Int(self.view.frame.width), height: height)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.genresView?.makeInvisible()
            self.whiteView?.frame = rect
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.platformView?.makeVisible()
            })
        }
        
        //Set new current active view
        self.currentActiveSectionView = views.second
        
    }//------------------------------- Supporting Functions --------------------
//    //Checks all buttons
//    //if no buttons are selected -> return false
//    private func checkButtonsSelected(btnArr: [UIButton]) -> Bool{
//        for button in btnArr {
//            if button.isSelected {
//                return true
//            }
//        }
//        return false
//    }
    
    private func getSelecteddBtns(btnArr: [UIButton]) -> [UIButton] {
        var selectedBtns = [UIButton]()
        //If button is selected, add it to the return array
        for button in btnArr {
            if button.isSelected {
                selectedBtns.append(button)
            }
        }
        return selectedBtns
    }
    
    //------------------------ Objc functions --------------------------------
    @objc private func blueNextBtnPressed() {
        //Animate to second view
        animateToSecondView()
    }
    
    @objc private func whiteNextBtnPressed(){
        animateToThirdView()
    }
    
    @objc private  func finishBtnPressed(){
        //Check interests buttons
        let selectedBtns = self.getSelecteddBtns(btnArr: self.interestButtons!)
        //if none are selected, give warning
        //If more than  3 are selected, give warning
        if selectedBtns.isEmpty {
            self.areYouSureWarning()
            return
        } else if selectedBtns.count > 3 {
            self.tooManyInterestsWarning()
            return
        }
        //if one, two, or three are selected, proceed with registration
        
        
        
        //Segue to next screen
        self.performSegue(withIdentifier: "comingSoonSegue", sender: self)
    }
    
    @objc private func loginBtnPressed(){
        //Make segue to login screen
        self.performSegue(withIdentifier: "registerToLoginSegue", sender: self)
    }
    
    @objc private func platformBtnPressed(sender: UIButton){
        sender.toggle()
        
        if sender.isSelected {
            UIView.animate(withDuration: 0.3, animations: {
                sender.backgroundColor = darkBlueColor
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                sender.backgroundColor = whiteColor
            })
        }
    }
    
    @objc private func interestBtnPressed(sender: UIButton) {
        sender.toggle()
        
        if sender.isSelected {
            UIView.animate(withDuration: 0.3, animations: {
                sender.tintColor = darkBlueColor
                sender.backgroundColor = darkBlueColor
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                sender.tintColor = lightBlueColor
                sender.backgroundColor = lightBlueColor
            })
        }
    }
    
    @objc private func selectProfilePictureBtnPressed() {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true){
            
        }
    }
    
    //Function to pick image from the phone of the user
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            self.profNameView?.bigImageView.image = image
            self.firstSection?.bigImageView.image = image
            self.firstSection?.middleImageView.image = image
            self.firstSection?.smallImageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //----------------------------------- Gesture recognizers ---------------------------------
    private func addSwipeGestureRecognizers(){
        let up = UISwipeGestureRecognizer(target: self, action: #selector(lightBlueUpSwipe))
        up.direction = .up
        self.lightblueView!.addGestureRecognizer(up)
        
        let down = UISwipeGestureRecognizer(target: self, action: #selector(lightBlueDownSwipe))
        down.direction = .down
        self.lightblueView!.addGestureRecognizer(down)
        
        let whiteUp = UISwipeGestureRecognizer(target: self, action: #selector(whiteUpSwipe))
        whiteUp.direction = .up
        self.whiteView!.addGestureRecognizer(whiteUp)
        
        let whiteDown = UISwipeGestureRecognizer(target: self, action: #selector(whiteDownSwipe))
        whiteDown.direction = .down
        self.whiteView!.addGestureRecognizer(whiteDown)
    }
    
    @objc func lightBlueUpSwipe() {
        //Animation
        if self.currentActiveSectionView == self.views.first {
            self.animateToSecondView()
        }
    }
    
    @objc func lightBlueDownSwipe() {
        if self.currentActiveSectionView == self.views.second {
            self.animateToFirstView()
        }
    }
    
    @objc func whiteUpSwipe() {
        if self.currentActiveSectionView == self.views.second {
            self.animateToThirdView()
        }
    }
    
    @objc func whiteDownSwipe() {
        if self.currentActiveSectionView == self.views.third {
            self.animateToSecondViewFromThirdView()
        }
    }
    
    //------------------------- Pop up warnings -------------------------------------
    //Warning alert when profile name isn't filled in
    func notFilledInWarning() {
        let alertController = UIAlertController(title: "Oops!", message:
            "It seems you didn't pick a profile name", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func areYouSureWarning(){
        let alertController = UIAlertController(title: "Hold up!", message:
            "Don't you have interests?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "I don't have interests", style: .default))
        alertController.addAction(UIAlertAction(title: "Add interests", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func platformWarning() {
        let alertController = UIAlertController(title: "Oh no!", message:
            "Please tell us on which platforms brands can find you", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tooManyInterestsWarning() {
        let alertController = UIAlertController(title: "Hold your horses!", message:
            "Please select no more than 3 interests", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
