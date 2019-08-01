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
    
    var profileNameLbl : UILabel?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        profileNameLbl = self.createProfileLbl(name: "Profile Name")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setProfilePictureBtnPressed(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true){
            
        }
    }
    
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
        })
    }
    
    func createProfileLbl(name : String) -> UILabel {
        //Init label
        let label = UILabel(frame: CGRect(x: 135, y: 258, width: 200, height: 30))
        
        // font
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.font = UIFont.init(name: "CocoGothic-Bold", size: 23)
        
        // color
        label.textColor = whiteColorInvisible
        
        //Alignment
        label.textAlignment = .left
        
        //Text
        label.text = name
        
        self.view.addSubview(label)
        
        return label
    }
    
    func labelAnimation() {
        //Set new color
        profileNameLbl!.textColor = whiteColor
        //Set center position
        profileNameLbl!.center = CGPoint(x: 235, y: 165)
    }
    
}
