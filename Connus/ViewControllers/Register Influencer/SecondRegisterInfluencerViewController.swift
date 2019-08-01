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
    var birthdate: Timestamp?
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
        let email = emailTextView.text!
        let password = passwordTextField.text!
        let phoneNumber = phoneNumerTextView.text!
        //Create user in firebase
        Auth.auth().createUser(withEmail: email, password: password, completion: {(result, error) in
            if let error = error {
                print("Failed signup with firebase: ", error.localizedDescription)
                return
            }
            
            guard let uid = result?.user.uid else {
                print("Error finding current user")
                return
            }
            
            //Upload user data
            self.uploadUserDataToFirebase(email: email, phoneNumber: phoneNumber, uid: uid)
            
            //Upload profile pic
            self.uploadProfilePic(uid: uid)
        })
        
        //Segue to next screen
        self.performSegue(withIdentifier: "influencerHome", sender: self)
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
            //Do nothing
        }
    }
    
    //Upload the chosen profile pic to Firebase Storage
    //Get the downloadurl to save with the user data
    func uploadProfilePic(uid : String) {
        //Get current user id
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("No User logged in")
//            return
//        }
        // Upload the file to the path "profilepics/uid.png"
        if self.profilePictureImageView.image != nil {
            let storageRef = storage.reference().child("profilepics/"+uid+".png")
            let imgData = self.profilePic?.pngData()
            var picUrl = ""
            _ = storageRef.putData(imgData!, metadata: nil) { (metadata, error) in
                // You can also access to download URL after upload.
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Failed uploading profile picture", error.localizedDescription)
                    } else {
                        print("Succesfully uploaded profile picture to storage!")
                    }
                    guard let profUrl = url else {
                        print("No URL found")
                        return
                    }
                    picUrl = profUrl.absoluteString
                    db.collection(INFLUENCERPATH).document(uid).updateData([PROFILEURL : picUrl], completion: { (error) in
                        if let error = error {
                            print("Failed to update user", error.localizedDescription)
                        } else {
                            print("Succesfully updated user data with profile picture URL!")
                        }
                    })
                }
            }
        } else {
            print("No profile pic uploaded")
            return
        }
    }
    
    //Upload the given user data from the register screen into Firebase Firestore
    func uploadUserDataToFirebase(email : String, phoneNumber : String, uid : String){
        //Get current user id
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("No User logged in")
//            return
//        }
        //Values to store in firestore
        let values = [EMAIl: email, PHONE: phoneNumber, FIRSTNAME: self.name!, LASTNAME: self.lastname!, BIRTHDAY: self.birthdate!, COUNTRY: self.country!, GENDER: self.gender!, PROFILEURL: ""] as [String : Any]
        
        db.collection(INFLUENCERPATH).document(uid).setData(values as [String : Any]) {
            err in
            if let err = err {
                print("Error saving user data in firestore: \(err)")
            } else {
                print("User data succesfully saved!")
            }
        }
    }
    
    //Warning alert when not everything is filled in
    func notFilledInWarning() {
        let alertController = UIAlertController(title: "Oops!", message:
            "Please fill in all necessary fields", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Warning alert when passwords don't match
    func passwordsMismatchWarning() {
        let alertController = UIAlertController(title: "Oops!", message:
            "Passwords don't match", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
