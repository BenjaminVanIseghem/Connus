//
//  ChoiceViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 29/07/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Back button tint
        self.navigationController?.navigationBar.tintColor = whiteColor
        //set rounded top corners for whiteView
        self.whiteView.roundTopCorners()
    }
    
    @IBAction func influencerBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "influencerRegisterSegue", sender: self)
    }
    
}
