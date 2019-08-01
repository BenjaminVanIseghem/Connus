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
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgottenPasswordBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "passwordForgottenSegue", sender: self)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        //TODO Sign in using credentials
        //Fetch values from textfields
        guard let email = emailTxtField.text else {
            print("No email")
            return
        }
        guard let password = passwordTxtField.text else {
            print("No password")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
            guard error != nil else {
                print("Error signing in user")
                return
            }
            print("User succesfully signed in!")
            
            //Segue to influencer flow
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
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
