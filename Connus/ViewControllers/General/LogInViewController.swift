//
//  LogInViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 29/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    //UI elements
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    //View
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Back button tint
        self.navigationController?.navigationBar.tintColor = whiteColor
        //Set battery and other top icons to white
        navigationController?.navigationBar.barStyle = .black
        //Set rounded top corners for whiteView
        whiteView.roundTopCorners()
    }
    
    @IBAction func forgottenPasswordBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "passwordForgottenSegue", sender: self)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        //TODO Sign in using credentials
        //Fetch values from textfields
        guard let email = emailTxtField.text, email != "" else {
            notFilledInWarning()
            return
        }
        guard let password = passwordTxtField.text, password != "" else {
            notFilledInWarning()
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
            guard error == nil else {
                self.wrongLoginInfoWarning()
                print("Error signing in user", error as Any)
                return
            }
            print("User succesfully signed in!")
            
            let uid = result?.user.uid
            db.collection(INFLUENCERPATH).document(uid!).getDocument() {result, error in 
                if error != nil {
                    print(error!)
                    return
                }
                if result!.exists {
                    print("INFLUENCER SIGNED IN")
                    //Segue to influencer flow
                    self.performSegue(withIdentifier: "signedInfluencerSegue", sender: self)
                } else {
                    print("NOT AN INFLUENCER")
                }
                
            }
            db.collection(COMPANIESPATH).document(uid!).getDocument() {result, error in
                if error != nil {
                    print(error!)
                    return
                }
                if result!.exists {
                    print("BRAND SIGNED IN")
                    //Segue to influencer flow
                    self.performSegue(withIdentifier: "signedBrandSegue", sender: self)
                } else {
                    print("NOT A BRAND")
                }
            }
            
            
        }
    }
    
    //Warning alert when not everything is filled in
    func notFilledInWarning() {
        let alertController = UIAlertController(title: "Oops!", message:
            "It seems you didn't fill in all the fields", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Warning alert when the login info is wrong
    func wrongLoginInfoWarning() {
        let alertController = UIAlertController(title: "Oops!", message:
            "You have entered an invalid email or password", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Preparation for the segue to the PasswordForgottenViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passwordForgottenSegue" {
            guard let email = emailTxtField.text else {
                return
            }
            //Fetch ViewController
            let dest = segue.destination as! PasswordForgottenViewController
            //Set email field
            dest.email = email
        }
    }
}
