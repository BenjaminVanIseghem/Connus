//
//  SecondRegisterInfluencerViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 01/05/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import Firebase
import UIKit

class SecondRegisterInfluencerViewController : UIViewController {
    //Firestore path
    let collectionpath = "influencers"
    //UI elements-------------------------------------------------
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var phoneNumerTextView: UITextField!
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    //------------------------------------------------------------
    //Variables from previous register screen---------------------
    var name: String?
    var lastname: String?
    var birthdate: String?
    var country: String?
    var gender: String?
    var profilePic: UIImage?
    //------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePictureImageView.setRounded()
        profilePictureImageView.image = profilePic
    }
    
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "backToFirstRegisterInfluencer", sender: self)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        var picUrl: String?
        let email = emailTextView.text!
        let password = passwordTextField.text!
        let phoneNumber = phoneNumerTextView.text!
        Auth.auth().createUser(withEmail: email, password: password, completion: {(result, error) in
            if let error = error {
                print("Failed signup with firebase: ", error.localizedDescription)
                return
            }
            guard let uid = result?.user.uid else { return }
            
            // Upload the file to the path "images/rivers.jpg"
            if self.profilePic != nil {
                let storageRef = Storage.storage().reference().child("profilepics/"+uid+".png")
                let imgData = self.profilePic?.pngData()
                _ = storageRef.putData(imgData!, metadata: nil) { (metadata, error) in
                    // You can also access to download URL after upload.
                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            print("Failed uploading profile picture", error.localizedDescription)
                        }
                        picUrl = url?.absoluteString
                    }
                }
            } else {
                picUrl = " "
            }
            
            //Values to store in firestore
            let values = [EMAIl: email, PHONE: phoneNumber, FIRSTNAME: self.name, LASTNAME: self.lastname, BIRTHDAY: self.birthdate, COUNTRY: self.country, GENDER: self.gender, PROFILEURL: picUrl]
            
            Firestore.firestore().collection(self.collectionpath).document(uid).setData(values as [String : Any])
        })
        Auth.auth().signIn(withEmail: email, password: password, completion: { (AuthDataResult, error) in
            if let error = error {
                print("Failed login with firebase: ", error.localizedDescription)
                return
            }
        })
        
        performSegue(withIdentifier: "influencerHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToFirstRegisterInfluencer" {
            let controller = segue.destination as! RegisterInfluencerViewController
            controller.name = self.name
            controller.lastname = self.lastname
            controller.birthdate = self.birthdate
            controller.country = self.country
            controller.gender = self.gender
            if profilePic != nil {
                controller.profilePic = self.profilePic
            }
        } else if segue.identifier == "influencerHome" {
//            let controller = segue.destination as! InfluencerHomeViewController
//            controller.history = self.history
            print("influencerHome")
        }
    }
    
    //Warning alert when not everything is filled in
    func notFilledInWarning() {
        let alertController = UIAlertController(title: "Oops!", message:
            "Please fill in all necessary fields", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
