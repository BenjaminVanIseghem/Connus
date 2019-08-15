//
//  ComingSoonViewController.swift
//  Connus
//
//  Created by Benjamin Van Iseghem on 15/08/2019.
//  Copyright © 2019 Connus. All rights reserved.
//

import UIKit

class ComingSoonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.makeNavigationControllerTranslucent()
        //Set battery and wifi icons to white
        navigationController?.navigationBar.barStyle = .black
    }
}
