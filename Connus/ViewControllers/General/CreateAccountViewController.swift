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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set battery and wifi icons to black
        navigationController?.navigationBar.barStyle = .black
        //Back button tint
        self.navigationController?.navigationBar.tintColor = whiteColor
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        
        
        self.performSegue(withIdentifier: "choiceSegue", sender: self)
    }
    
}
