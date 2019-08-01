//
//  ChoiceViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 29/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func influencerBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "influencerRegisterSegue", sender: self)
    }
    
}
