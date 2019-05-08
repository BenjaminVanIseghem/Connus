//
//  FirstViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 26/04/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController {

    @IBOutlet weak var user: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        user.text = Auth.auth().currentUser?.email
    }


}

