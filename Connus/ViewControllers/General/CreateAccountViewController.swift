//
//  CreateAccountViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 29/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var whiteView: UIView!
    //Text Fields
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordtxtField: UITextField!
    @IBOutlet weak var secondPasswordTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set battery and wifi icons to black
        navigationController?.navigationBar.barStyle = .black
        //Back button tint
        self.navigationController?.navigationBar.tintColor = whiteColor
        //Round the whiteview top corners
        self.whiteView.roundTopCorners()
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        //check that all fields are filled in
        guard let email = emailTxtField.text, isEmailFilledIn(email: email), let password = passwordtxtField.text, isPasswordFilledIn(password: password), let secPassword = secondPasswordTxtField.text, passwordsMatch(password: password, secPassword: secPassword) else {
                //Give warning
            self.notFilledInWarning()
            return
        }
        //Create firebase user which automatically signs the new user in
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            guard error == nil else {
                self.firebaseAlert(description: error!.localizedDescription)
                return
            }
            //Segue to next screen if no errors occurred
            self.performSegue(withIdentifier: "choiceSegue", sender: self)
        })
    }
    
    //Warning alert when profile name isn't filled in
    func notFilledInWarning() {
        let alertController = UIAlertController(title: "Oops!", message:
            "Not all fields are filled in", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Warning alert when Firebase returns an error
    func firebaseAlert(description: String) {
        let alertController = UIAlertController(title: "Oops!", message:
            description, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Check if email is valid
    private func isEmailFilledIn(email: String) -> Bool {
        if email == "" {
            return false
        }
        return true
    }
    
    //Check password guidelines
    private func isPasswordFilledIn(password: String) -> Bool {
        if password == "" {
            return false
        }
        return true
    }
    
    //Check if passwords match
    private func passwordsMatch(password: String, secPassword: String) -> Bool {
        return true
    }
    
}
