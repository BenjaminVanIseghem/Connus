//
//  PasswordForgottenViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 30/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordForgottenViewController: UIViewController {
    
    //Variables
    var email : String?
    
    //UI elements
    @IBOutlet weak var emailTxtField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData() {
        guard email != nil else {
            return
        }
        emailTxtField.text = email
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        guard let email = emailTxtField.text else {
            print("No email given")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            if error != nil {
                self.emailWarning()
            } else {
                self.succes()
            }
        }
    }
    
    //Warning alert when Firebase return error
    func emailWarning() {
        let alertController = UIAlertController(title: "Oops!", message:
            "Please present a valid email", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Succes notification
    func succes(){
        let alertController = UIAlertController(title: "Succes!", message:
            "A password reset link has been sent to your email", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: { action in
            self.segueBack()
        })
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func segueBack(){
        self.performSegue(withIdentifier: "succesSegue", sender: self)
    }
}
