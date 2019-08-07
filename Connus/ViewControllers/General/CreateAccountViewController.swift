//
//  CreateAccountViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 29/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = whiteColor
        self.navigationController?.navigationBar.hideShadow()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        self.performSegue(withIdentifier: "choiceSegue", sender: self)
    }
    
}
