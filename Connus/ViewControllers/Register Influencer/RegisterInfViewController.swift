//
//  RegisterInfViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 29/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class RegisterInfViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Connected UI elements
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var smallImageView: UIImageView!
    @IBOutlet weak var profileNameTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var selectProfileBtn: UIButton!
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var locationStackView: UIStackView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var lightBlueView: UIView!
    @IBOutlet weak var whiteView: UIView!
    
    //Labels
    var profileNameLbl : UILabel?
    var nameAndLocationLbl : UILabel?
    var platformsLbl : UILabel?
    var genresLbl : UILabel?
    var genresInfoLbl : UILabel?
    
    //Buttons
    var whiteNextBtn : UIButton?
    var finishBtn : UIButton?
    
    //Other
    var platformButtons : [UIButton] = []
    var platformButtonsView : UIView?
    var genresButtons : [UIButton] = []
    var genresButtonsView : UIView?
    var currentActiveView : String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hideShadow()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navigation bar color
        self.navigationController?.navigationBar.barTintColor = darkBlueColor

        //Create extra labels
        profileNameLbl = self.createProfileLbl()
        nameAndLocationLbl = self.createNameAndLocationLabel()
        //create invisible elements to show on swipe or next button press
        createElementsForLightBlueView()
        whiteView.isUserInteractionEnabled = true
        createElementsForWhiteView()
        //Set current active view
        self.currentActiveView = "darkBlueView"
        
        //Add gesture recognizers
        addSwipeGestureRecognizers()
    }
    
    @IBAction func setProfilePictureBtnPressed(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true){
            
        }
    }    
    
    //Function to pick image from the phone of the user
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            bigImageView.image = image
            middleImageView.image = image
            smallImageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        self.animateToSecondView()
    }

//----------------------- View elements ------------------------------
    //Create the profile name label
    func createProfileLbl() -> UILabel {
        //Init label
        let label = UILabel(frame: CGRect(x: 135, y: 258, width: 240, height: 30))
        // font
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFont.init(name: "CocoGothic-Bold", size: 23)
        // color
        label.textColor = whiteColor
        //Alignment
        label.textAlignment = .left
        //Text
        label.text = "Profile Name"
        //Invisible
        label.makeInvisible()
        //Add to view
        self.view.addSubview(label)
        
        return label
    }
    
    //Create the name and location label
    func createNameAndLocationLabel() -> UILabel {
        //Init label
        let label = UILabel(frame: CGRect(x: 135, y: 296, width: 240, height: 40))
        // font
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.font = UIFont.init(name: "CocoGothic", size: 14)
        // color
        label.textColor = .lightGray
        //Alignment
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        //Text
        label.text = "name, location"
        //Invisible
        label.makeInvisible()
        //Add to view
        self.view.addSubview(label)
        
        return label
    }
//-------------------------------------------------------------
//-------------------------- Animations -----------------------
    func moveProfileNameAndLocationLabelsToTop() {
        //Set value from profile text field as text for label
        var profName = self.profileNameTxtField.text
        if profName == "" {
            profName = "Profile Name"
        }
        self.profileNameLbl?.text = profName
        
        //Set name and location as text for label
        // --> get name and location from previous screens  TODO!!!!
        
        //Set center position
        profileNameLbl!.center = CGPoint(x: 255, y: 165)
        nameAndLocationLbl?.center = CGPoint(x: 255, y: 200)
        
        //Make visible
        profileNameLbl?.makeVisible()
        nameAndLocationLbl?.makeVisible()
    }
    
    func moveProfileNameAndLocationLabelBack() {
        //Set center position
        profileNameLbl!.center = CGPoint(x: 255, y: 258)
        nameAndLocationLbl?.center = CGPoint(x: 255, y: 296)
        //Make invisible
        profileNameLbl?.makeInvisible()
        nameAndLocationLbl?.makeInvisible()
    }
    
    //Move bigImageView back and forth (1 = first position, 2 = second position)
    func moveBigImageView(position : Int) {
        let size = self.bigImageView.frame.size
        switch position {
        case 1:
            let newY = 258 + size.height / 2
            let newX = 40 + size.width / 2
            
            self.bigImageView.center = CGPoint(x: newX, y: newY)
        case 2:
            let newY = 150 + size.height / 2
            let newX = 40 + size.width / 2
            
            self.bigImageView.center = CGPoint(x: newX, y: newY)
        default:
            print("Not a correct value!")
        }
    }
    
    //Use this function in as an animation to  make these invisible in the view
    func hideDarkBlueViewElements() {
        //Label
        self.infoLbl.makeInvisible()
        
        //Images
        self.middleImageView.makeInvisible()
        self.smallImageView.makeInvisible()
        
        //Button
        self.selectProfileBtn.makeInvisible()
        self.nextBtn.makeInvisible()
        
        //Stack Views
        self.profileStackView.makeInvisible()
        self.locationStackView.makeInvisible()
    }
    
    func showDarkBlueViewElements() {
        //Label
        self.infoLbl.makeVisible()
        
        //Images
        self.middleImageView.makeVisible()
        self.smallImageView.makeVisible()
        
        //Button
        self.selectProfileBtn.makeVisible()
        self.nextBtn.makeVisible()
        
        //Stack Views
        self.profileStackView.makeVisible()
        self.locationStackView.makeVisible()
    }
    
    //Grow the lightBlueView
    func growLightBlueView() {
        //positions & dimensions
        let yPos = self.view.frame.height / 3
        let width = self.view.frame.width
        let height = self.view.frame.height - yPos
        //Create rect to use as frame
        let rect = CGRect(x: 0, y: yPos, width: width, height: height)
        //Set view frame
        self.lightBlueView.frame = rect
    }
    
    //Shrink the lightBlueview
    func shrinkLightBlueView() {
        //positions & dimensions
        let yPos = self.view.frame.height - 250
        let width = self.view.frame.width
        let height = self.view.frame.height - yPos
        //Create rect to use as frame
        let rect = CGRect(x: 0, y: yPos, width: width, height: height)
        //Set view frame
        self.lightBlueView.frame = rect
    }
    
    //Hide UI Elements
    func hideLightBlueViewElements() {
        platformsLbl?.makeInvisible()
        platformButtonsView?.makeInvisible()
        whiteNextBtn?.makeInvisible()
    }
    
    //Show UI elements
    func showLightBlueViewElements() {
        self.platformsLbl?.makeVisible()
        self.whiteNextBtn?.makeVisible()
        self.platformButtonsView?.makeVisible()
    }
    
    //Grow view
    func growWhiteView() {
        //positions & dimensions
        let yPos = (self.view.frame.height / 3) + 90
        let width = self.view.frame.width
        let height = self.view.frame.height - yPos
        
        //Create rect to use as frame
        let rect = CGRect(x: 0, y: yPos, width: width, height: height)
        
        //Set view frame
        self.whiteView.frame = rect
    }
    
    //Shrink view
    func shrinkWhiteView() {
        //Position and dimensions
        let yPos = self.view.frame.height - 150
        let width = self.view.frame.width
        let height = self.view.frame.height - yPos
        //Rect
        let rect = CGRect(x: 0, y: yPos, width: width, height: height)
        //Set as frame
        self.whiteView.frame = rect
    }
    
    //Show UI Elements
    func showWhiteViewElements() {
        genresLbl?.makeVisible()
        genresInfoLbl?.makeVisible()
        genresButtonsView?.makeVisible()
        finishBtn?.makeVisible()
    }
    
    //Hide UI Elements
    func hideWhiteViewElements() {
        genresLbl?.makeInvisible()
        genresInfoLbl?.makeInvisible()
        genresButtonsView?.makeInvisible()
        finishBtn?.makeInvisible()
    }
//--------------------------------------------------
//---------------- Create Views --------------------
    func createPlatformButtonsView() {
        //Dimensions & positions
        let xPos = 40
        let yPos = Int(self.platformsLbl!.frame.maxY) + 20
        let width = Int(self.lightBlueView.frame.width) - 80
        let height = 120
        
        //Create rect
        let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
        //Init view
        let view = UIView(frame: rect)
        //Color
        view.backgroundColor = self.lightBlueView.backgroundColor
        view.isOpaque = true
        //Invisible
        view.makeInvisible()
        //Add to superview (lightBlueView)
        self.lightBlueView.addSubview(view)
        //Save newly created view to buttonsView
        self.platformButtonsView = view
    }
    
    func createGenresButtonsView() {
        //Dimensions & positions
        let xPos = 40
        let yPos = Int(self.genresInfoLbl!.frame.maxY) + 20
        let width = Int(self.whiteView.frame.width) - 80
        let height = 160

        //Create rect
        let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
        //Init view
        let view = UIView(frame: rect)
        //Color
        view.backgroundColor = self.whiteView.backgroundColor
        view.isOpaque = true
        //Invisible
        view.makeInvisible()
        //Add to superview (lightBlueView)
        self.whiteView.addSubview(view)
        //Save newly created view to buttonsView
        self.genresButtonsView = view
    }
//---------------------------------------------------------
//-------- Create elements for lightBlueView---------------
    func createElementsForLightBlueView() {
        let viewFrame = self.lightBlueView.frame
        //Label
        //Init label
        let label = UILabel(frame: CGRect(x: 40, y: 60, width: viewFrame.width - 40, height: 50))
        // font
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.font = UIFont.init(name: "CocoGothic-Bold", size: 23)
        // color
        label.textColor = whiteColor
        //Alignment
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        //Make invisible
        label.makeInvisible()
        
        //Text
        label.text = "Platforms that show your work"
        
        //Save label onto platformsLbl
        self.platformsLbl = label
        //-------------------------------------------
        
        //Create the view where all the buttons will be placed
        self.createPlatformButtonsView()
        //Create all the buttons (invisible because view is still invisible)
        self.makePlatformButtons()
        
        //-------------------Button------------------
        let button = UIButton(type: .system)
        //Make rect for frame
        let rect = CGRect(x: viewFrame.width - 120, y: platformButtonsView!.frame.maxY + 50, width: 80, height: 30)
        //Set button frame
        button.frame = rect
        //Color
        button.backgroundColor = whiteColor
        button.setTitleColor(lightBlueColor, for: .normal)
        //Font
        button.titleLabel?.font = UIFont(name: "CocoGothic-Bold", size: 14)
        //Text
        button.setTitle("Next", for: .normal)
        //Rounded corners
        button.layer.cornerRadius = 15
        //Make invisible
        button.makeInvisible()
        //Make clickable
        button.addTarget(self, action: #selector(whiteNextBtnPressed), for: .touchUpInside)
        //Save button onto whiteNextBtn
        self.whiteNextBtn = button
        //---------------------------------
        
        //Add views to lightBlueView
        self.lightBlueView.addSubview(label)
        self.lightBlueView.addSubview(button)
    }
    
    //Objective C function, action for button press (nextBtn)
    @objc func whiteNextBtnPressed(sender : UIButton) {
        self.animateToThirdView()
    }
    
    //Creates the buttons which represent all the social media platforms
    func makePlatformButtons() {
        //Frame
        let viewFrame = self.platformButtonsView!.frame
        //Dimensions for each button
        let width = 50
        let height = 50
        let spaceBetweenButtons = 20
        //Check how many can be shown in 1 row
        let amountPerRowFloat = viewFrame.width / CGFloat(integerLiteral: width + spaceBetweenButtons)
        //Round amountPerRowFloat
        let roundedAmountPerRowFloat = amountPerRowFloat.rounded()
        //Convert to integer (easier to work with)
        let amountPerRow = Int(roundedAmountPerRowFloat)
        for (platform, index) in PLATFORMS {
            //Init button as system button for click animations
            let button = UIButton(type: .system)
            
            if amountPerRow > index {
                //Positions
                let xPos = index * (width + spaceBetweenButtons)
                let yPos = 0
                //Init rect
                let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
                //Set rect as frame for button
                button.frame = rect
            } else {
                let calculatedValue = index - amountPerRow
                //Positions
                let xPos = calculatedValue * (width + spaceBetweenButtons)
                let yPos = height + spaceBetweenButtons
                //Init rect
                let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
                //Set rect as frame for button
                button.frame = rect
            }
            
            //Color
            button.backgroundColor = whiteColor
            button.tintColor = lightBlueColor
            //CornerRadius
            button.layer.cornerRadius = 10
            button.clipsToBounds  = true
            
            //button insets
            button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3);
            //Get image from platformname
            let image = UIImage(named: platform)
            //Set image as background image for button
            button.setImage(image, for: .normal)
            button.setImage(image, for: .selected)
            //Set action
            button.addTarget(self, action: #selector(platformBtnTapped), for: UIControl.Event.touchUpInside)
            //Append to array
            platformButtons.append(button)
            //Add to view
            self.platformButtonsView!.addSubview(button)
        }
    }
    
    @objc func platformBtnTapped(sender: UIButton) {
        sender.toggle()
        if sender.isSelected {
            
            sender.tintColor = darkBlueColor
        } else {
            sender.tintColor = lightBlueColor
        }
    }
//---------------------------------------------------------
//----------------- Create elements for white view --------
    func createElementsForWhiteView() {
        let viewFrame = self.whiteView.frame
        //---------------- Label ---------------------------
        //Rect for label
        let rect = CGRect(x: 40, y: 60, width: viewFrame.width - 40, height: 25)
        //Init label
        let label = UILabel(frame: rect)
        // font
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFont.init(name: "CocoGothic-Bold", size: 23)
        // color
        label.textColor = nearlyBlackColor
        //Alignment
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        //Text
        label.text = "Genres of interest"
        //Invisible
        label.makeInvisible()
        //Save label
        self.genresLbl = label
        //--------------------------------------------------
        //---------------- Second Label --------------------
        //Rect for second label
        let secondRect = CGRect(x: 40, y: label.frame.maxY + 5, width: viewFrame.width - 40, height: 20)
        //Init second label
        let secondLabel = UILabel(frame: secondRect)
        // font
        secondLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        secondLabel.font = UIFont.init(name: "CocoGothic", size: 17)
        // color
        secondLabel.textColor = lightGrayColor
        //Alignment
        secondLabel.textAlignment = .left
        secondLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        secondLabel.numberOfLines = 0
        //Text
        secondLabel.text = "Max. 3 genres"
        //Invisible
        secondLabel.makeInvisible()
        //Save label
        self.genresInfoLbl = secondLabel
        //--------------------------------------------------
        //---------------- Genre buttons -------------------
        self.createGenresButtonsView()
        self.fillGenresButtonView()
        //--------------------------------------------------
        //---------------- Button --------------------------
        //Button
        let button = UIButton(type: .system)
        //Calc yPos
        let whiteViewHeight = self.view.frame.height - ((self.view.frame.height / 3) + 90)
        //Make rect for frame
        let btnRect = CGRect(x: viewFrame.width - 120, y: whiteViewHeight - 150, width: 80, height: 30)
        //Set button frame
        button.frame = btnRect
        //Color
        button.backgroundColor = lightBlueColor
        button.setTitleColor(whiteColor, for: .normal)
        //Font
        button.titleLabel?.font = UIFont(name: "CocoGothic-Bold", size: 14)
        //Text
        button.setTitle("Finish", for: .normal)
        //Rounded corners
        button.layer.cornerRadius = 15
        //Make invisible
        button.makeInvisible()
        //Make clickable
        button.addTarget(self, action: #selector(finishBtnPressed), for: .touchUpInside)
        //Save button
        self.finishBtn = button
        //--------------------------------------------------
        
        
        //Add labels to super view
        self.whiteView.addSubview(label)
        self.whiteView.addSubview(secondLabel)
        self.whiteView.addSubview(button)
    }
    
    //FINAL BUTTON, save everything to firebase
    @objc func finishBtnPressed() {
        //TODO
    }
    
    func fillGenresButtonView() {
        //Frame
        let viewFrame = self.genresButtonsView!.frame
        //Dimensions for each button
        let width = 60
        let height = 30
        let spaceBetweenButtons = 10
        //Check how many can be shown in 1 row
        let amountPerRowFloat = viewFrame.width / CGFloat(integerLiteral: width + spaceBetweenButtons)
        //Round amountPerRowFloat
        let roundedAmountPerRowFloat = amountPerRowFloat.rounded()
        //Convert to integer (easier to work with)
        let amountPerRow = Int(roundedAmountPerRowFloat)
        for (genre, index) in GENRES {
            //Init button as system button for click animations
            let button = UIButton(type: .system)
            
            if amountPerRow > index {
                //Positions
                let xPos = index * (width + spaceBetweenButtons)
                let yPos = 0
                //Init rect
                let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
                //Set rect as frame for button
                button.frame = rect
            } else {
                let calculatedValue = index - amountPerRow
                //Positions
                let xPos = calculatedValue * (width + spaceBetweenButtons)
                let yPos = height + spaceBetweenButtons
                //Init rect
                let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
                //Set rect as frame for button
                button.frame = rect
            }
            
            //Color
            button.backgroundColor = lightBlueColor
            button.setTitleColor(whiteColor, for: .normal)
            button.setTitleColor(greenColor, for: .selected)
            button.tintColor = .clear
            //CornerRadius
            button.layer.cornerRadius = CGFloat(integerLiteral: height / 2)
            //Font
            button.titleLabel?.font = UIFont(name: "CocoGothic-Bold", size: 14)
            //Title
            button.setTitle(genre, for: .normal)
            //Set action
            button.addTarget(self, action: #selector(genreBtnTapped), for: UIControl.Event.touchUpInside)
            //Append to array
            genresButtons.append(button)
            //Add to view
            self.genresButtonsView!.addSubview(button)
        }
    }
    
    @objc func genreBtnTapped(sender: UIButton) {
        sender.toggle()
    }
//---------------------------------------------------------
    
    func addSwipeGestureRecognizers(){
        let up = UISwipeGestureRecognizer(target: self, action: #selector(lightBlueUpSwipe))
        up.direction = .up
        self.lightBlueView.addGestureRecognizer(up)
        
        let down = UISwipeGestureRecognizer(target: self, action: #selector(lightBlueDownSwipe))
        down.direction = .down
        self.lightBlueView.addGestureRecognizer(down)
        
        let whiteUp = UISwipeGestureRecognizer(target: self, action: #selector(whiteUpSwipe))
        whiteUp.direction = .up
        self.whiteView.addGestureRecognizer(whiteUp)
        
        let whiteDown = UISwipeGestureRecognizer(target: self, action: #selector(whiteDownSwipe))
        whiteDown.direction = .down
        self.whiteView.addGestureRecognizer(whiteDown)
    }
    
    @objc func lightBlueUpSwipe() {
        if currentActiveView == "darkBlueView" {
            self.animateToSecondView()
        }
    }
    
    @objc func lightBlueDownSwipe() {
        if currentActiveView == "lightBlueView" {
            self.animateToFirstView()
        }
    }
    
    @objc func whiteUpSwipe() {
        if currentActiveView == "lightBlueView" {
            self.animateToThirdView()
        }
    }
    
    @objc func whiteDownSwipe() {
        if currentActiveView == "whiteView" {
            self.animateToSecondViewFromThirdView()
        }
    }
    
    //Do all the animations to get back to the first view
    func animateToFirstView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hideLightBlueViewElements()
            self.shrinkLightBlueView()
            self.moveBigImageView(position: 1)
            self.moveProfileNameAndLocationLabelBack()
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.showDarkBlueViewElements()
            })
        }
        self.currentActiveView = "darkBlueView"
    }
    //Do all the animations to get to the second view
    func animateToSecondView() {
        UIView.animate(withDuration: 0.5, animations: {
            //Move big image view to the second position
            self.moveBigImageView(position: 2)
            self.moveProfileNameAndLocationLabelsToTop()
            self.hideDarkBlueViewElements()
            self.growLightBlueView()
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.showLightBlueViewElements()
            })
        }
        self.currentActiveView = "lightBlueView"
    }
    //Do all the animations to get back to the second view
    func animateToSecondViewFromThirdView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hideWhiteViewElements()
            self.shrinkWhiteView()
            self.growLightBlueView()
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.showLightBlueViewElements()
            })
        }
        self.currentActiveView = "lightBlueView"
    }
    //Do all the animations to get to the third view
    func animateToThirdView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.hideLightBlueViewElements()
            self.growWhiteView()
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.showWhiteViewElements()
            })
        }
        self.currentActiveView = "whiteView"
    }
}
