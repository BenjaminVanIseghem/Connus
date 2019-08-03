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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        profileNameLbl = self.createProfileLbl()
        nameAndLocationLbl = self.createNameAndLocationLabel()
        createElementsForLightBlueView()
        createElementsForWhiteView()
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
        let size = self.bigImageView.frame.size
        let newY = 150 + size.height / 2
        let newX = 40 + size.width / 2
            
        UIView.animate(withDuration: 0.5, animations: {
            self.bigImageView.center = CGPoint(x: newX, y: newY)
            self.createProfileNameAndLocationLabels()
            self.makeBlueElementsInvisible()
            self.transformLightBlueView()
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.showLightBlueViewElements()
            })
        }
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
        label.textColor = whiteColorInvisible
        
        //Alignment
        label.textAlignment = .left
        
        //Text
        label.text = "Profile Name"
        
        self.view.addSubview(label)
        
        return label
    }
    
    func createNameAndLocationLabel() -> UILabel {
        //Init label
        let label = UILabel(frame: CGRect(x: 135, y: 296, width: 240, height: 40))
        
        // font
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.font = UIFont.init(name: "CocoGothic", size: 14)
        
        // color
        label.textColor = whiteColorInvisible
        
        //Alignment
        label.textAlignment = .left
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        
        //Text
        label.text = "name, location"
        
        self.view.addSubview(label)
        
        return label
    }
//-------------------------------------------------------------
//-------------------------- Animations -----------------------
    func createProfileNameAndLocationLabels() {
        //Set value from profile text field as text for label
        var profName = self.profileNameTxtField.text
        if profName == "" {
            profName = "Profile Name"
        }
        self.profileNameLbl?.text = profName
        
        //Set name and location as text for label
        // --> get name and location from previous screens  TODO!!!!
        
        //Set new color
        profileNameLbl!.textColor = whiteColor
        nameAndLocationLbl?.textColor = .lightGray
        
        //Set center position
        profileNameLbl!.center = CGPoint(x: 255, y: 165)
        nameAndLocationLbl?.center = CGPoint(x: 255, y: 200)
    }
    
    //Use this function in as an animation to  make these invisible in the view
    func makeBlueElementsInvisible() {
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
    
    //Makes visible the UI elements of the lightBlueView
    func showLightBlueViewElements() {
        self.platformsLbl?.makeVisible()
        self.whiteNextBtn?.makeVisible()
        self.platformButtonsView?.makeVisible()
    }
    
    //Show the elements in the light blue view
    func transformLightBlueView() {
        //positions & dimensions
        let yPos = self.view.frame.height / 3
        let width = self.view.frame.width
        let height = self.view.frame.height - yPos
        
        //Create rect to use as frame
        let rect = CGRect(x: 0, y: yPos, width: width, height: height)
        
        //Set view frame
        self.lightBlueView.frame = rect
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
        let yPos = Int(self.genresLbl!.frame.maxY) + 20
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
        UIView.animate(withDuration: 0.5, animations: {
            self.hideLightBlueViewElements()
            self.growWhiteView()
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.showWhiteViewElements()
            })
        }
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
            //CornerRadius
            button.layer.cornerRadius = 10
            //Get image from platformname
            let image = UIImage(named: platform)
            //Set image as background image for button
            button.setImage(image, for: .normal)
            //Append to array
            platformButtons.append(button)
            //Add to view
            self.platformButtonsView!.addSubview(button)
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
        //Make rect for frame
        let btnRect = CGRect(x: viewFrame.width - 120, y: label.frame.maxY + 160, width: 80, height: 30)
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
    
    @objc func finishBtnPressed() {
        //TODO
    }
    
    func fillGenresButtonView() {
        //TODO
    }
//---------------------------------------------------------
    
    func hideLightBlueViewElements() {
        platformsLbl?.makeInvisible()
        platformButtonsView?.makeInvisible()
        whiteNextBtn?.makeInvisible()
    }
    
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
    
    func showWhiteViewElements() {
        genresLbl?.makeVisible()
        genresInfoLbl?.makeVisible()
        finishBtn?.makeVisible()
    }
}
