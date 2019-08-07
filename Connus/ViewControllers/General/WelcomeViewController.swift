//
//  WelcomeViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 04/08/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        // Do any additional setup after loading the view
    }
}
