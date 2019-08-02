//
//  RegisterInfViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 29/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class RegisterInfViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //UI elements
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
    
    var profileNameLbl : UILabel?
    var nameAndLocationLbl : UILabel?
    var platformsLbl : UILabel?
    var genresLbl : UILabel?
    
    var whiteNextBtn : UIButton?
    var finishBtn : UIButton?
    
    var platformButtons : [UIButton] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        profileNameLbl = self.createProfileLbl()
        nameAndLocationLbl = self.createNameAndLocationLabel()
        makeUIForLightBlueView()
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
            self.labelAnimation()
            self.invisibleAnimation()
            self.showLightBlueView()
            self.createButtonsView()
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.showLightBlueElements()
            })
        }
    }
    
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
    
    func labelAnimation() {
        //Set value from profile text field as text for label
        var profName = self.profileNameTxtField.text
        if profName == "" {
            profName = "Profile Name"
        }
        self.profileNameLbl?.text = profName
        
        //Set name and location as text for label
        // --> get name and location from previous screens
        
        //Set new color
        profileNameLbl!.textColor = whiteColor
        nameAndLocationLbl?.textColor = .lightGray
        
        //Set center position
        profileNameLbl!.center = CGPoint(x: 255, y: 165)
        nameAndLocationLbl?.center = CGPoint(x: 255, y: 200)
    }
    
    //Use this function in as an animation to  make these invisible in the view
    func invisibleAnimation() {
        //Label
        self.infoLbl.alpha = CGFloat(integerLiteral: 0)
        
        //Images
        self.middleImageView.alpha = CGFloat(integerLiteral: 0)
        self.smallImageView.alpha = CGFloat(integerLiteral: 0)
        
        //Button
        self.selectProfileBtn.alpha = CGFloat(integerLiteral: 0)
        self.nextBtn.alpha = CGFloat(integerLiteral: 0)
        
        //Stack Views
        self.profileStackView.alpha = CGFloat(integerLiteral: 0)
        self.locationStackView.alpha = CGFloat(integerLiteral: 0)
    }
    
    //Show the elements in the light blue view
    func showLightBlueView() {
        let y = self.view.frame.height / 3
        let rect = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height - y)
        self.lightBlueView.frame = rect
    }
    
    func makeUIForLightBlueView() {
        let viewFrame = self.lightBlueView.frame
        //Label
        //Init label
        let label = UILabel(frame: CGRect(x: 40, y: 60, width: viewFrame.width - 40, height: 50))
        // font
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.font = UIFont.init(name: "CocoGothic-Bold", size: 23)
        // color
        label.textColor = whiteColorInvisible
        //Alignment
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        
        //Text
        label.text = "Platforms that show your work"
        
        //---------------------------------
        //Button
        let button = UIButton(type: .system)
        //Make rect for frame
        let rect = CGRect(x: viewFrame.width - 120, y: label.frame.maxY + 160, width: 80, height: 30)
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
        button.alpha = CGFloat(integerLiteral: 0)
        //Make clickable
        button.addTarget(self, action: #selector(whiteNextBtnPressed), for: .touchUpInside)
        //---------------------------------
        
        //Add views to lightBlueView
        self.lightBlueView.addSubview(label)
        self.lightBlueView.addSubview(button)
            
        //Set variables
        self.platformsLbl = label
        self.whiteNextBtn = button
    }
    
    @objc func whiteNextBtnPressed(sender : UIButton) {
        print("TODO")
    }
    
    //Makes the UI elements of the lightBlueView visible
    func showLightBlueElements() {
        self.platformsLbl?.textColor = whiteColor
        self.whiteNextBtn?.alpha = CGFloat(integerLiteral: 1)
        
        self.makePlatformButtons()
    }
    
    //Creates the buttons which represent all the social media platforms
    func makePlatformButtons() {
        //Frame
        let viewFrame = self.lightBlueView.frame
        //Dimensions for each button
        let width = 50
        let height = 50
        let spaceBetweenButtons = 20
        let distanceFromBound = 40
        //Check how many can be shown in 1 row
        let amountPerRowFloat = (viewFrame.width - (CGFloat(integerLiteral: distanceFromBound) * 2) ) / CGFloat(integerLiteral: width + spaceBetweenButtons)
        //Round amountPerRowFloat
        let roundedAmountPerRowFloat = amountPerRowFloat.rounded()
        //Convert to integer (easier to work with)
        let amountPerRow = Int(roundedAmountPerRowFloat)
        for (platform, index) in PLATFORMS {
            //Init button as system button for click animations
            let button = UIButton(type: .system)
            
            if amountPerRow > index {
                //Positions
                let xPos = 40 + (index * 20) + (index * width)
                let yPos = Int(self.platformsLbl!.frame.maxY) + 20
                //Init rect
                let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
                //Set rect as frame for button
                button.frame = rect
            } else {
                let calculatedValue = index - amountPerRow
                //Positions
                let xPos = 40 + (calculatedValue * 20) + (calculatedValue * width)
                let yPos = Int(self.platformsLbl!.frame.maxY) + 90
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
            self.lightBlueView.addSubview(button)
        }
    }
    
    func createButtonsView() {
        
    }
    
}
