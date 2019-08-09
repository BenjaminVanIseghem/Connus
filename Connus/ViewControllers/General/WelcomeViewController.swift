//
//  WelcomeViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 04/08/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var createAccountBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Make navigationbar translucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        //Set color of the logo  image
        logoImageView.tintColor = lightBlueColor
        //Set button properties
        self.createAccountBtn.setRounded()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Set battery and wifi icons to black
        navigationController?.navigationBar.barStyle = .default
    }
}
